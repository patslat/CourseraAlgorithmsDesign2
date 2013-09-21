MST
input : undirected graph
output : min cost spanning tree (no cycles, connected)
assumes: g is connected, distinct edge cost(not necess)
cut property: if e is the cheapest edge crossing some cut a,b then e
                e belongs to the mst
PRIM one starting point and add on to it

KRUSKALS just pick cheapest edge, and skip ones that create cycles
  doesn't worry about maintaining connectivity

def KRUSKALS
  sort edges in order of increasing cost
  T = ø
  for for i = 1 to m edges
    if T U [i] has no cycles
    add i to T
return T

let T* = output of KRUSKALS
T* is connected. why?
By empty cut lemma, only need to show that T* crosses every cut
Fix a cut [A,B] since G connected at least one of its edges cross(A,B)

lonely cut corrolary, if an edge is the sole edge crossing a cut, there is
no way that this edge can create a cycle

naive = O(mlogn) + O(mn) = O(mn)
O(mn) dominates O(mlogn)

UNION FIND
raison d'etre of union find data structure
maintain partition of a set of objects
FIND(x) #=> name of group that x belongs to
UNION(Ci,Cj)#=> fuse groups Ci and Cj into a single one

Why useful for kruskal's algorithm: connected components with current
chosen edges in T

Union Find data structure
maintain a linked struct per connected component
each component has an arbitrary leader vertex
each vertex points to the leader of its component
each vertex inherits the name of its leader component

given edge (U,V) can check if UV already n same component O(1)
IFF leader pointers of U,V match FIND(u) == FIND(v)
O(1) time cycle checks

When new edge (U,V) addedto T, connected components of a U & V merge
worst case asymptotically to merge and restore the invariant:
  BIG THETA(n)
when two components merge:
reuse either group 1 or group 2's leader and make other group inherit it
(KEEP LEADER OF LARGER GROUP DERP)
Maintain a size field for each group
Still BIG THETA(n)

How many times does a single vert have its leader pointed updated over
the course of KRUSKALS: BIG THETA(logn)
each pointer will see its leader updated a logarithmic number of times
the size of the union needs to be at least double the size of the current.
  log2n

So far
O(mlogm) to sort edges
O(m) for cycle checks [O(1) per iteration]
O(nlogn) time for leader pointer updates

ZOMG O(mlogn) JUST AS GOOD AS PRIMS!

MST can be solved in O(m) using a randomized algorithm
thanks Karger-Klein-Tarjan

Do not know if there is a linear time deterministic algorithm for MST

O(malpha(n)) deterministic [Chazelle] => inverse Ackerman Function

log*n can apply log to n until result drops below 1
  inverse of tower function 2^2^2^2^2^2

CLUSTERING
given n points classify into coherent groups (Unsupervised learning)
input: (dis)similarity measure d(p,q) between two points
output: clusters

MAX SPACING K CLUSTERINGS
Assume we know k = # of desired clusters
  [in practice, can experiment with a range of values]

call points p&q separated if they're assigned to different clusters
definition the SPACING of k-clustering is min separated(p, q)
bigger spacing is better.

Problem statement: given a dist measured d and k, compute the k-clustering
with maximum spacing

GREEDY ALGORITHM
start: each point is its own cluster
increase objective function as much as possible, selected pair of points
that is closest and fuse them into a common cluster. Only way
to merge two points in different clusters, merge both containing clusters

VERY SIMILAR TO KRUSKALS MST but stops when K is met
points <=> vertices; distances <=> edge costs; point pairs <=> edges

single-link clustering

Correctness Claim
Theorem:
Single link clustering finds the max spacing k-clustering

Proof let C1..Ck = greedy clustering with spacing S.
let C1...Ck = arbitrary other clustering
