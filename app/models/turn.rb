class Turn < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_map
end
