class TopsController < ApplicationController
  def index
    # map_clear
    @map = map_init
    @fields = @map.game_fields
    @intersections = @map.game_intersections
    @sides = @map.game_sides

    @map.join(current_user)
  end

  def turn_end
    map = current_user.turn.game_map
    if current_user.turn == map.current_turn && map.start && map.next_turn
      get_resources
      map.turns.each do |t|
        WebsocketRails.users[t.user_id].send_message :draw_info, render_to_string(
            partial: 'tops/infos', locals: {map: map, user: t.user})
      end

      if (users_data = map.end2?(5))
        map.game_end
        result = users_data.map{|user, point| "#{user.name} : #{point}"}.join("\n")
        users_data.each do |user, point|
          broadcast = WebsocketRails.users[user.id]
          broadcast.send_message :notice, {result: result}
        end
      end
    end
  end

  def get_resources
    @dice = dice
    @get_maps = GameField.where(number:@dice)
    for m in @get_maps do
      for v in m.vertices.all do

        #全ての六角形を見て、どこかの頂点に建物が建っていれば
 			  if v.game_intersection.game_building
 				  @resource_type_id = m.resource_type_id
          @get_users = v.game_intersection.game_building.user
          GameResource.create(user: @get_users, resource_type: ResourceType.find_by_id(@resource_type_id))
 			  end
  	  end
    end
  end

  def trade
    if current_user.resources(params[:export]).count >= 4
      GameResource.delete(current_user.game_resources.where(resource_type:ResourceType.find_by_name(params[:export])).limit(4))
      current_user.game_resources.where(resource_type:ResourceType.find_by_name(params[:import])).create
      map = current_user.turn.game_map
      map.turns.each do |t|
        WebsocketRails.users[t.user_id].send_message :draw_info, render_to_string(
            partial: 'tops/infos', locals: {map: map, user: t.user})
      end
      render nothing:true
    else
      render "tops/trade"
    end
  end

  def reset
    if params[:password] == 'katan'
      map_clear
      flash[:notice] = 'success'
    end
  end
end
