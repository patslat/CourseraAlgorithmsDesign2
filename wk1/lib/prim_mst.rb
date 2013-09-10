def process_edges(edges_filename)
  edges = File.read(edges_filename)
    .split("\n")
  num_nodes, num_edges = edges.delete_at(0).split(" ")

end

p process_edges("lib/edges.txt")
