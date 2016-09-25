module TopsHelper
  def map_init
    if not map = GameMap.first
      map = GameMap.create
      resource_types = ResourceType.all
      # intersection => [f1, f2, f3]
      relations = [[0,3,4],[0,3],[0],[0],[0,1],[0,1,4],[1,4,5],[1],[1,2],[1,2,5],[2,5,6],[2],[2],[2,6],[3,7,8],[3,7],[3],[3,4,8],[4,8,9],[4,5,9],[5,9,10],[5,6,10],[6,10,11],[6],[6,11],[7,12],[7],[7],[7,8,12],[8,12,13],[8,9,13],[9,13,14],[9,10,14],[10,14,15],[10,11,15],[11,15],[11],[11],[12,16],[12],[12,13,16],[13,16,17],[13,14,17],[14,17,18],[14,15,18],[15,18],[15],[16],[16],[16,17],[17],[17,18],[18],[18]]
      next_intersections = [[1,5,17],[0,2,16],[1,3],[2,4],[3,5,7],[0,4,6],[5,9,19],[4,8],[7,9,11],[6,8,10],[9,13,21],[8,12],[11,13],[10,12,23],[15,17,28],[14,16,27],[1,15],[0,14,18],[17,19,30],[6,18,20],[19,21,32],[10,20,22],[21,24,34],[13,24],[22,23,36],[26,28,39],[25,27],[15,26],[14,25,29],[28,30,40],[18,29,31],[30,32,42],[20,31,33],[32,34,44],[22,33,35],[34,37,46],[24,37],[35,36],[39,40,48],[25,38],[29,38,41],[40,42,49],[31,41,43],[42,44,51],[33,43,45],[44,46,53],[35,45],[48,49],[38,47],[41,47,50],[49,51],[43,50,52],[51,53],[45,52]]
      side_relations = []
      next_intersections.each_with_index do |n, i|
        n.each do |x|
          side_relations.push [x, i] unless side_relations.include? [i, x]
        end
      end

      side_relations.each_with_index do |relation, index|
        GameSide.create game_map: map, positionA: relation[0], positionB: relation[1], position: index
      end

      19.times do |i|
        GameField.create game_map: map, number: rand(1..12), resource_type: resource_types.sample
      end
      fields = map.game_fields
      relations.each_with_index do |v, p|
        intersection = GameIntersection.create game_map: map, position: p
        3.times do |i|
          Vertex.create game_field: v[i] ? fields[v[i]] : nil, game_intersection: intersection
        end
      end

      intersections = map.game_intersections
      next_intersections.each_with_index do |nexts, center|
        intersections.find_by(position: center).vertices.each_with_index do |v, index|
          next unless (n = nexts[index])
          side = map.game_sides.find_by(positionA: center, positionB: n) || map.game_sides.find_by(positionB: center, positionA: n)
          v.update next_intersection_id: intersections[n].id, game_side: side
        end
      end
    end
    map
  end

  def map_clear
    GameMap.delete_all
    GameField.delete_all
    GameResource.delete_all
    GameBuilding.delete_all
    GameIntersection.delete_all
    GameSide.delete_all
    Vertex.delete_all
  end
end
