class GameBuilding < ActiveRecord::Base
  has_many :game_sides
  has_many :game_intersections
end
