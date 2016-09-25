class GameMap < ActiveRecord::Base
  has_many :turns
  has_many :game_sides
  has_many :game_intersections
  has_many :game_fields

  def next_turn
    unless first?
      t_number = self.turn_number + 1
      t_number = 0 if self.max_member <= t_number
      self.update turn_number: t_number
    end
  end

  def next_first_turn
    if first?
      if self.first
        t_number = self.turn_number + 1
        if self.max_member <= t_number
          self.first = false
          t_number = self.turn_number
        end
      else
        t_number = self.turn_number - 1
        if t_number <= 0
          self.first2 = false
        end
      end
      self.update turn_number: t_number, first: self.first, first2: self.first2
    end
  end

  def first?
    self.first || self.first2
  end

  def current_turn
    # self.turns.find_by_number(self.turn_number)
    self.turns[self.turn_number]
  end
end
