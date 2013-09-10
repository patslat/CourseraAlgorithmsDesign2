def process_edges(edges_filename)
  edges = File.read(edges_filename)
    .split("\n")
  num_nodes, num_edges = edges.delete_at(0).split(" ").map(&:to_i)
  edges.map! { |edge| edge.split(" ").map(&:to_i) }
  return num_nodes, num_edges, edges
end

num_nodes, num_edges, edges = process_edges("lib/edges.txt")

