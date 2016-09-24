class GameMap < ActiveRecord::Base
  has_many :turns
  has_many :game_sides
  has_many :game_intersections
  has_many :game_fields

  def next_turn
    t_number = self.turn_number + 1
    t_number = 0 if self.max_member <= t_number
    self.update turn_number: t_number
  end

  def current_turn
    # self.turns.find_by_number(self.turn_number)
    self.turns[self.turn_number]
  end
end
