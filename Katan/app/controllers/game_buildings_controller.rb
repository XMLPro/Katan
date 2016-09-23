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
    @data[:result] = if params[:intersection_id]
                       create_from_intersection
                     elsif params[:side_id]
                       create_from_side
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

    def create_from_intersection
      # ここに建物が建つと同時に資源を消費するコードを書く
      # 資源が足りているかどうかも
      intersection = GameIntersection.find_by id: params[:intersection_id]

      #建物が建つか？
      possible = false
      vertices = intersection.vertices
      vertices.each do |v|
        if (b = v.game_side&.game_building) && b.user == current_user
          possible = true
          break
        end
      end

      if possible
        vertices.each do |v|
          if (id = v.next_intersection_id) && GameIntersection.find_by_id(id).game_building
            return false
          end
        end
      else
        return false
      end

      #建物を建てる
      build = intersection.game_building || GameBuilding.new(building_params)
      normal = BuildingType.find_by_name :normal
      building_type = case build.building_type
                    when nil
                      normal
                    when normal
                      BuildingType.find_by_name :special
                    else
                      nil
                  end
      return false unless building_type
      build.building_type = building_type
      @data[:place] = :intersection
      if build.save
        intersection.update game_building: build
        @data[:position] = intersection.position
        @data[:building_type] = build.building_type.name
        true
      else
        false
      end
    end

    def create_from_side
      side = GameSide.find_by id: params[:side_id]
      unless side.game_building
        #建物が建つか？
        possible = false
        roads = current_user.game_buildings.where(building_type: BuildingType.find_by_name(:bridge))
        if roads.count >= 2
          current_user_id = current_user.id
          intersection_a = GameIntersection.find_by_position(side.positionA)
          intersection_b = GameIntersection.find_by_position(side.positionB)
          sides = intersection_a.vertices.map{|v| v.game_side&.game_building&.user_id} + intersection_b.vertices.map{|v| v.game_side&.game_building&.user_id}
          sides.each do |s|
            p s
            if s == current_user_id
              possible = true
              break
            end
          end

          return false unless possible
        end

        #建物を建てる
        build = GameBuilding.new(building_params)
        build.building_type = BuildingType.find_by(name: :bridge)
        @data[:place] = :side
        if build.save
          side.update game_building: build
          @data[:position] = side.position
          @data[:building_type] = build.building_type.name
          true
        else
          false
        end
      end
    end
end
