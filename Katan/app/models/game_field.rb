class GameField < ActiveRecord::Base
  belongs_to :game_resource
  has_many :game_maps
end
