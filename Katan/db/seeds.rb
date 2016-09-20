# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ResourceType.create name: :grass
ResourceType.create name: :iron
ResourceType.create name: :tree
ResourceType.create name: :soil

BuildingType.create name: :normal
BuildingType.create name: :special
BuildingType.create name: :bridge
