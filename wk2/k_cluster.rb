class KCluster
  def initialize(filename)
    @edges, @graph, @size = read_file(filename)
  end

  def read_file(filename)
    graph = Hash.new { |hash, key| hash[key] = [] } # adjacency list
    edges = File.readlines(filename).map do |edge|
      e = edge.chomp.split(' ').map(&:to_i)
      graph[e[0]] << e[1] unless e.length == 1
      e
    end
    size = edges.shift

    edges.sort! do |e1, e2|
      e1[2] <=> e2[2] # sort by edge weight ascending
    end

    return edges, graph, size

  end

  def k_cluster(n)
    vertices = @graph.keys.map { |vertex| [vertex] }
    edges = @edges.clone

    until vertices.length == n
      u, v, _ = edges.shift
      if different_group?(vertices, u, v)
        group1_idx = vertices.find_index { |group| group.include?(u) }
        group2_idx = vertices.find_index { |group| group.include?(v) }

        vertices[group1_idx] += vertices[group2_idx]

        vertices.delete_at(group2_idx)
      end
    end
    p vertices
    find_min_distance(vertices, edges)
  end

  private
  def different_group?(vertices, u, v)
    vertices.any? do |group|
      group.include?(u) && !group.include?(v)
    end &&
    vertices.any? do |group|
      group.include?(v) && !group.include?(u)
    end
  end

  def find_min_distance(vertices, edges)
    edges.each do |edge|
      return edge[2] if different_group?(vertices, edge[0], edge[1])
    end
  end

end

k_cluster = KCluster.new('clustering.txt')

p k_cluster.k_cluster(4)
