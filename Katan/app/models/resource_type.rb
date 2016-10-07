class ResourceType < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :game_resources
end
