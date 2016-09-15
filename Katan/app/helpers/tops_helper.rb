module TopsHelper
  def map_init
    if not map = GameMap.first
      map = GameMap.create
      tree = ResourceType.find_by_name :tree
      # intersection => [f1, f2, f3]
      relations = [[0,3,4],[0,3],[0],[0],[0,1],[0,1,4],[1,4,5],[1],[1,2],[1,2,5],[2,5,6],[2],[2],[2,6],[3,7,8],[3,7],[3],[3,4,8],[4,8,9],[4,5,9],[5,9,10],[5,6,10],[6,10,11],[6],[6,11],[7,12],[7],[7],[7,8,12],[8,12,13],[8,9,13],[9,13,14],[9,10,14],[10,14,15],[10,11,15],[11,15],[11],[11],[12,16],[12],[12,13,16],[13,16,17],[13,14,17],[14,17,18],[14,15,18],[15,18],[15],[16],[16],[16,17],[17],[17,18],[18],[18]]
      19.times do |i|
        GameField.create game_map: map, number: i, resource_type: tree
      end
      fields = map.game_fields
      relations.each_with_index do |v, p|
        intersection = GameIntersection.create game_map: map, position: p
        v.each do |i|
          Vertex.create game_field: fields[i], game_intersection: intersection
        end
      end
    end
    map
  end

  def map_clear
    GameMap.delete_all
    GameField.delete_all
    Vertex.delete_all
    GameIntersection.delete_all
  end
end
