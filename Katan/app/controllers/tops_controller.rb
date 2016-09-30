class TopsController < ApplicationController
  def index
    # map_clear
    @map = map_init
    @fields = @map.game_fields
    @intersections = @map.game_intersections
    @sides = @map.game_sides

    if (user = current_user) && !current_user.turn
      Turn.create user: user, game_map: @map
    end
  end

  def turn_end
    map = current_user.turn.game_map
    @result = if map.next_turn
                get_resources
                map.current_turn.user.name
              end
  end

  def get_resources
  	@dice = dice
  	@get_maps = GameField.where(number:@dice)
    for m in @get_maps do
      for v in m.vertices.all do
 			  if v.game_intersection.game_building
 				 @resource_type_id = m.resource_type_id
 				 GameResource.create(user: current_user, resource_type: ResourceType.find_by_id(@resource_type_id))
 			  end
  	 end
    end
  end
end
