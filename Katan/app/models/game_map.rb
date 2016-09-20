class GameMap < ActiveRecord::Base
  has_many :game_fields
  has_many :game_sides
  has_many :game_intersections
end
