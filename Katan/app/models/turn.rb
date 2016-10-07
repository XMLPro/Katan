class Turn < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_map

  def get_number
    self.game_map.turns.index(self)
  end
end
