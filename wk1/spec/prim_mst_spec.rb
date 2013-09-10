require 'rspec'
require_relative '../lib/prim_mst'

describe "process_edges" do
  it "takes a filename and returns number of nodes, number of edges, and the edges" do
    num_nodes, num_edges, edges = process_edges("lib/edges.txt")
    num_nodes.should == 500
    num_edges.should == 2184
    edges.length.should == num_edges
  end
end
