class TopsController < ApplicationController
  def index
    # map_clear
    @map = map_init
    @fields = @map.game_fields
    @intersections = @map.game_intersections
    @sides = @map.game_sides

    if @map.join(current_user)
      @map.turns.map{|t| t.user}.each do |user|
        broadcast = WebsocketRails.users[user.id]
        broadcast.send_message :draw_info, render_to_string(
            partial: 'tops/infos', locals: {map: @map, user: user})
      end
    end
  end

  def turn_end
    map = current_user.turn.game_map
    if map.next_turn
      get_resources(map)
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

  def trade
    if current_user.resources(params[:export]).count >= 4
      GameResource.delete(current_user.game_resources.where(resource_type:ResourceType.find_by_name(params[:export])).limit(4))
      current_user.game_resources.where(resource_type:ResourceType.find_by_name(params[:import])).create
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
