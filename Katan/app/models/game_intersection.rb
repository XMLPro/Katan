class GameIntersection < ActiveRecord::Base
  belongs_to :game_building
  has_many :vertices
end
