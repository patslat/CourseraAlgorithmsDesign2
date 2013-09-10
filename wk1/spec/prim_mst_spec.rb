require 'rspec'
require_relative '../lib/prim_mst'

describe "Prim's MST Algorithm" do
  num_vertices, num_edges, edges = process_edges("lib/edges.txt")

  describe "process_edges" do
    it "takes a filename and returns number of nodes, number of edges, and the edges" do
      num_vertices.should == 500
      num_edges.should == 2184
      edges.length.should == num_edges
    end
  end

  describe "get_vertices" do
    it "returns the vertices of a set of edges" do
      get_vertices(edges).length.should == num_vertices
    end
  end

  describe "prim_mst" do
    it "finds the mst of a small set of edges from lecture" do
      edges = [[1, 2, 1], [1, 3, 4], [1, 4, 3], [2, 4, 2], [3, 4, 5]]
      sort_edges_by_weight(prim_mst(edges)).should == [[1, 2, 1], [2, 4, 2], [1, 3, 4]]
    end
  end
end
