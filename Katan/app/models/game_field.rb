class GameField < ActiveRecord::Base
  belongs_to :resource_type
  belongs_to :game_map
  has_many :vertices
end
