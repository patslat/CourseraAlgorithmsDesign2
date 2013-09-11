def process_edges(edges_filename)
  edges = File.read(edges_filename)
    .split("\n")
  num_nodes, num_edges = edges.delete_at(0).split(" ").map(&:to_i)
  edges.map! { |edge| edge.split(" ").map(&:to_i) }
  return num_nodes, num_edges, edges
end

def sort_edges_by_weight(edges)
  edges.clone.sort do |edge1, edge2|
    edge_1_weight, edge_2_weight = edge1[2], edge2[2]
    edge_1_weight <=> edge_2_weight
  end
end

def get_vertices(edges)
  edges.map do |edge|
    edge[0..1]
  end.flatten.uniq
end

def prim_mst(edges)
  vertices = get_vertices(edges)
  visited = [vertices.sample]
  sorted_edges = sort_edges_by_weight(edges)
  mst = []
  until visited == vertices
    # find the first edge (least weight) that crosses the frontier
    next_edge = sorted_edges.find do |edge|
      visited.include?(edge[0]) && !visited.include?(edge[1]) ||
      visited.include?(edge[1]) && !visited.include?(edge[0])
    end
    return mst unless next_edge
    # add the unvisited edge
    visited << next_edge.find { |vertex| !visited.include?(vertex) }
    mst << next_edge
    sorted_edges.delete(next_edge)
  end
end

num_nodes, num_edges, edges = process_edges("lib/edges.txt")
p "The weight of the minimum spanning tree is: "
p prim_mst(edges).reduce(0) { |weight, edge| weight += edge[2] }
