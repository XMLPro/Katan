begin
  ResourceType.create name: :sheep
  ResourceType.create name: :wheat
  ResourceType.create name: :iron
  ResourceType.create name: :tree
  ResourceType.create name: :soil

  BuildingType.create name: :normal
  BuildingType.create name: :special
  BuildingType.create name: :bridge
rescue
  puts "何か問題が発生しました。"
end
