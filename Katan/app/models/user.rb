class User < ActiveRecord::Base
  has_many :game_buildings
end
