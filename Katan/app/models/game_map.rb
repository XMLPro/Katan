class GameMap < ActiveRecord::Base
  belongs_to :game_field
  has_many :turns

  def next_turn
    t_number = self.turn_number + 1
    t_number = 0 if self.max_member <= t_number
    self.update turn_number: t_number
  end

  def turn_user
    self.turns.find_by_number(self.turn_number)
  end
end
