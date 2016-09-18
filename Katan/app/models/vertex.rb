class Vertex < ActiveRecord::Base
  belongs_to :game_field
  belongs_to :game_side
  belongs_to :game_intersection
end
