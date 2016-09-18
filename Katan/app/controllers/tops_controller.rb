class TopsController < ApplicationController
  def index
    map_clear
    @map = map_init
    @fields = @map.game_fields
    @intersections = @map.game_intersections
    @sides = @map.game_sides
  end
end
