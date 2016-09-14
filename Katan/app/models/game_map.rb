class GameMap < ActiveRecord::Base
  has_many :game_fields
end
