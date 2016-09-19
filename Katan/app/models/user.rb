class User < ActiveRecord::Base
  validates :name,  presence: true,
    length: { maximum: 12 },
    uniqueness: true
  has_many :game_buildings
  has_one :turn
end
