module TopsHelper
  def map_init
    map = GameMap.create
    tree = ResourceType.find_by_name :tree
    19.times do
      f = GameField.create game_map: map, resource_type: tree
      6.times do
        Vertex.create game_field: f
      end
    end
  end

  def map_clear
    GameMap.delete_all
    GameField.delete_all
  end
end
