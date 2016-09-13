class GameResource < ActiveRecord::Base
  has_many :game_fields
  belongs_to :resource_type
end
