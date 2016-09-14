class GameIntersection < ActiveRecord::Base
  belongs_to :game_building
  belongs_to :game_map
  has_many :vertices
end
