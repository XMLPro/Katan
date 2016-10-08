class GameBuildingsController < ApplicationController
  def index
    @building = GameBuilding.new
    @users = User.all
  end

  def all
    @buildings = GameBuilding.all
  end

  def show
    @building = GameBuilding.find params[:id]
  end

  def update
    building = GameBuilding.find_by id: params[:game_building][:id]
    @result = (building and building.update building_params) ? :success : :failed
  end

  def create
    @data = {}
    turn = current_user.turn
    map = turn.game_map
    result = if turn != map.current_turn
                       false
                     elsif params[:intersection_id]
                       create_from_intersection map
                     elsif params[:side_id]
                       create_from_side map
             end
    if result
      map.turns.each do |t|
        broadcast = WebsocketRails.users[t.user_id]
        broadcast.send_message :draw_building, @data
        broadcast.send_message :draw_info, render_to_string(
          partial: 'tops/infos', locals: {map: map, user: t.user})
      end
    end
  end

  def destroy
    building = GameBuilding.find_by id: params[:game_building][:id]
    if building
      building.destroy
      @result = :success
    else
      @result = :failed
    end
  end

  private
    def building_params
      # params[:user_id] = current_user
      # params.require(:game_building).permit(:user_id)
      {user: current_user}
    end

    def create_from_intersection(map)
      intersection = GameIntersection.find_by id: params[:intersection_id]
      possible = false
      #建物が建つか？

      vertices = intersection.vertices
      # 隣接道
      return false unless vertices.any?{|v| (b = v.game_side&.game_building) && b.user == current_user}

      # 隣接家
      return false if vertices.any?{|v| (id = v.next_intersection_id) && map.game_intersections.find_by_id(id).game_building}

      if map.first # 初期ダーン
        buildings = current_user.game_buildings.where(building_type: BuildingType.find_by(name: :normal)).count
        if buildings < 1 # 一巡目
          possible = true
          roads = current_user.game_buildings.where(building_type: BuildingType.find_by(name: :bridge)).count
          map.next_first_turn if roads >= 1
        end
      elsif map.first2
        buildings = current_user.game_buildings.where(building_type: BuildingType.find_by(name: :normal)).count
        if buildings < 2 # 二巡目
          possible = true
          roads = current_user.game_buildings.where(building_type: BuildingType.find_by(name: :bridge)).count
          map.next_first_turn if roads >= 2
        end
      else # 通常ターン
      build = intersection.game_building || GameBuilding.new(building_params)
      normal = BuildingType.find_by_name :normal
      special = BuildingType.find_by_name :special
      #建物の状態によって資源チェック場合分け
      case build.building_type
      when nil
        if check_resource(tree:1 , soil:1 , wheat:1 , sheep:1)
          possible = true
        else
          return false
        end
      when normal
        if check_resource(iron:3, wheat:2)
          possible = true
        else
          return false
        end
      end
      end
      return false unless possible

      #建物を建てる
      build = intersection.game_building || GameBuilding.new(building_params)
      normal = BuildingType.find_by_name :normal
      special = BuildingType.find_by_name :special
      building_type = case build.building_type
                    when nil
                      normal
                    when normal
                      special
                    else
                      nil
                  end
      return false unless building_type
      build.building_type = building_type
      @data[:place] = :intersection
      unless map.first?
        begin
          #建物の状態によって資源消費場合分け
          case build.building_type
          when normal
            use_resource(tree:1 , soil:1 , wheat:1 , sheep:1)
          when special
            use_resource(iron:3, wheat:2)
          end
        rescue
# ignored
        end
      end
      if build.save
        intersection.update game_building: build
        @data[:position] = intersection.position
        @data[:image_name] = building_image(intersection)
        true
      else
        false
      end
    end

    def create_from_side(map)
      side = GameSide.find_by id: params[:side_id]
      unless side.game_building
        #建物が建つか？
        possible = false
        roads = current_user.game_buildings.where(building_type: BuildingType.find_by_name(:bridge))
        if map.first # 初期ダーン
          if roads.count < 1 # 一巡目
            intersection_a = map.game_intersections.find_by(position: side.positionA)
            intersection_b = map.game_intersections.find_by(position: side.positionB)
            possible = true if check_building(intersection_a, map) || check_building(intersection_b, map)
          end
        elsif map.first2
          if roads.count < 2 # 二巡目
            intersection_a = map.game_intersections.find_by(position: side.positionA)
            intersection_b = map.game_intersections.find_by(position: side.positionB)
            possible = true unless intersection_a.game_building || intersection_b.game_building
          end
        else # 通常ターン
          if check_resource(tree:1 , soil:1)
            possible = true
          else
            return false
          end
          current_user_id = current_user.id
          intersection_a = map.game_intersections.find_by_position(side.positionA)
          intersection_b = map.game_intersections.find_by_position(side.positionB)
          sides = intersection_a.vertices.map{|v| v.game_side&.game_building&.user_id} + intersection_b.vertices.map{|v| v.game_side&.game_building&.user_id}
          return false unless sides.any?{|s| s == current_user_id}
        end
        return false unless possible

        #建物を建てる
        build = GameBuilding.new(building_params)
        build.building_type = BuildingType.find_by(name: :bridge)
        @data[:place] = :side
        unless map.first? 
          use_resource(tree:1 , soil:1)
        end
        if build.save
          side.update game_building: build
          @data[:position] = side.position
          @data[:image_name] = building_image(side)
          true
        else
          false
        end
      end
    end

    def check_building(intersection, map)
      vertices = intersection.vertices
      !vertices.any?{|v| (id = v.next_intersection_id) && map.game_intersections.find_by_id(id).game_building}
    end

    def check_resource(**resources)
      # 必要な分の資源があるか？
      resources.each do |i , v|
        resources[i] = current_user.game_resources.where(resource_type:ResourceType.find_by_name(i))
        if resources[i].count < v
          return false
        end
      end
       return true
    end

    def use_resource(**resources)
      # 必要な分の資源を消費（削除）
      resources.each do |i , v|
        #複数個消えなかったから修正
        vcount = 0
        until vcount == v
          vcount += 1
          resources[i] = current_user.game_resources.where(resource_type:ResourceType.find_by_name(i))
          resources[i].first.destroy    
        end
      end
    end
end


