class TopsController < ApplicationController
  def index
    # map_clear
    @map = map_init
    @fields = @map.game_fields
    @intersections = @map.game_intersections
    @sides = @map.game_sides
  end

  def turn_end
  end

  def get_resources
  	@dice = dice
  	@get_maps = GameField.find_by(number:@dice)

 		for v in @get_maps.vertices.all do
 			if v.game_intersection.game_building
 				@resource_type_id = @get_maps.resource_type_id
 				GameResource.create(user: current_user, resource_type: ResourceType.find_by_id(@resource_type_id))
 			end
  	end
  end
end
