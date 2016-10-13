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
      self.update turn_count: self.turn_count + 1
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
        if t_number < 0
          self.first2 = false
          t_number = self.turn_number
        end
      end
      self.update turn_number: t_number, first: self.first, first2: self.first2
    end
  end

  def first?
    self.first || self.first2
  end

  def end?(n)
    self.turns.select{|t| t.user.calc_point >= n}.first
  end

  def end2?(n)
    self.turn_count >= n * self.max_member ? self.turns.map{|t| [t.user, t.user.calc_point]}.to_h.sort_by{|k, v| v} : nil
  end

  def current_turn
    # self.turns.find_by_number(self.turn_number)
    self.turns[self.turn_number]
  end

  def game_start
    self.update start: true
  end

  def game_end
    self.update start: false
  end

  def join(user)
    if user
      Turn.create user: user, game_map: self unless user.turn || self.start
      self.game_start if self.turns.count >= self.max_member
    end
  end
end
