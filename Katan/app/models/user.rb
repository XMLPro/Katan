class User < ActiveRecord::Base
  validates :name,  presence: true,
    length: { maximum: 12 },
    uniqueness: true
  validates :name, format: {without: /\W/}
  has_many :game_buildings
  has_many :game_resources
  has_one :turn

  def resources(name)
    self.game_resources.where(resource_type: ResourceType.find_by(name: name))
  end

  def calc_point
    self.game_buildings.where(building_type: BuildingType.find_by(name: :normal)).count +
    self.game_buildings.where(building_type: BuildingType.find_by(name: :special)).count*2
  end
end
