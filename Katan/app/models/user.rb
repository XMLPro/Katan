class User < ActiveRecord::Base
  validates :name,  presence: true,
    length: { maximum: 12 },
    uniqueness: true
  validates :name, format: {without: /\W/}
  has_many :game_buildings
  has_many :game_resources
end
