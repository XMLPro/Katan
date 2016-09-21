module ApplicationHelper
  def dice
    return rand(1..6) + rand(1..6)
  end
end
