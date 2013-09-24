class BigKCluster
  def initialize(filename)
    @vertices, @n, @size = read_file(filename)
  end

  def read_file(filename)
    graph = File.readlines(filename)
    graph.map! { |line| line.chomp.split().map(&:to_i) }
    n, size = graph.shift

    return graph, n, size
  end

  def find_k_clusters(min_dist)
    vertices = @vertices.dup
    cluster_leaders = []
    clusters = Hash.new { |hash, key| hash[key] = [] }

    vertices.each do |vertex|
      added = false
      cluster_leaders.each do |cluster_leader|
        if hamming_distance(vertex, cluster_leader) < min_dist
          added = true
          clusters[cluster_leader] << vertex
          break
        end
      end

      p cluster_leaders.length
      cluster_leaders << vertex unless added
    end

    return cluster_leaders.length
  end

  def hamming_distance(u, v)
    return nil if v.nil?
    dist = 0
    u.each_with_index do |bit, idx|
      dist += 1 if bit != v[idx]
    end
    dist
  end

  def val(binary)
    val = 0
    binary.length.times do |n|
      val += 2**n if binary[n] == 1
    end
    val
  end
end

bk = BigKCluster.new('big_clustering.txt')
#p bk

#p bk.find_k_clusters(3)
