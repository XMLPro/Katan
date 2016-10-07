# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'create user'
User.create name: :u1
User.create name: :u2
User.create name: :u3

puts 'create turn'
map = GameMap.first
User.all.each do |u|
  unless u.turn
    Turn.create user: u, game_map: map
  end
end
