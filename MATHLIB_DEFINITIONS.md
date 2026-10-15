# Mathlib definitions used in Challenge.lean (Kőnig's theorems and Dilworth's theorem)

Verbatim excerpts of the Mathlib definitions used by the statements in `Challenge.lean`, at the
pinned Mathlib revision `c55e6e786f49471c72fbddbec5415808896aec1e` (tag `v4.35.0-rc3`, repository
https://github.com/leanprover-community/mathlib4). Mathlib is released under the Apache-2.0
licence. Each excerpt gives the file and line at that revision; the complete source is at
`https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/<file>`.

These excerpts are provided so that the meaning of every imported notion used by the
Challenge can be audited without fetching Mathlib.

## SimpleGraph

`Mathlib/Combinatorics/SimpleGraph/Basic.lean`, line 95:

```lean
/-- A simple graph is an irreflexive symmetric relation `Adj` on a vertex type `V`.
The relation describes which pairs of vertices are adjacent.
There is exactly one edge for every pair of adjacent vertices;
see `SimpleGraph.edgeSet` for the corresponding edge set.
-/
@[ext, aesop safe constructors (rule_sets := [SimpleGraph]), wikidata Q141488]
structure SimpleGraph (V : Type u) where
  /-- The adjacency relation of a simple graph. -/
  Adj : V → V → Prop
  symm : Std.Symm Adj := by aesop_graph
  loopless : Std.Irrefl Adj := by aesop_graph
```

## SimpleGraph.edgeSet

`Mathlib/Combinatorics/SimpleGraph/Basic.lean`, line 483:

```lean
/-- `G.edgeSet` is the edge set for `G`.
This is an abbreviation for `edgeSetEmbedding G` that permits dot notation. -/
abbrev edgeSet (G : SimpleGraph V) : Set (Sym2 V) := edgeSetEmbedding V G
```

## SimpleGraph.neighborFinset

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 169:

```lean
/-- `G.neighborFinset v` is the `Finset` version of `G.neighborSet v` in case `G` is
locally finite at `v`. -/
def neighborFinset : Finset V :=
  (G.neighborSet v).toFinset
```

## SimpleGraph.degree

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 242:

```lean
/-- `G.degree v` is the number of vertices adjacent to `v`. -/
def degree : ℕ := #(G.neighborFinset v)
```

## Graph homomorphisms `G →g H`

`Mathlib/Combinatorics/SimpleGraph/Maps.lean`, line 293:

```lean
/-- A graph homomorphism is a map on vertex sets that respects adjacency relations.

The notation `G →g G'` represents the type of graph homomorphisms. -/
abbrev Hom :=
  RelHom G.Adj G'.Adj
```

## SimpleGraph.Coloring

`Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean`, line 74:

```lean
/-- An `α`-coloring of a simple graph `G` is a homomorphism of `G` into the complete graph on `α`.
This is also known as a proper coloring.
-/
abbrev Coloring (α : Type v) := G →g completeGraph α
```

## SimpleGraph.Colorable

`Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean`, line 163:

```lean
/-- Whether a graph can be colored by at most `n` colors. -/
def Colorable (n : ℕ) : Prop := Nonempty (G.Coloring (Fin n))
```

## Sym2

`Mathlib/Data/Sym/Sym2.lean`, line 100:

```lean
/-- `Sym2 α` is the symmetric square of `α`, which, in other words, is the
type of unordered pairs.

It is equivalent in a natural way to multisets of cardinality 2 (see
`Sym2.equivMultiset`).
-/
abbrev Sym2 (α : Type u) := Quot (Sym2.Rel α)
```

## Sym2.mk

`Mathlib/Data/Sym/Sym2.lean`, line 103:

```lean
/-- Constructor for `Sym2`. This is the quotient map `α × α → Sym2 α`. -/
protected abbrev Sym2.mk {α : Type*} (a b : α) : Sym2 α := Quot.mk (Sym2.Rel α) (a, b)
```

## SimpleGraph.lineGraph

`Mathlib/Combinatorics/SimpleGraph/LineGraph.lean`, line 34:

```lean
/--
The line graph of a simple graph `G` has its vertex set as the edges of `G`, and two vertices of
the line graph are adjacent if the corresponding edges share a vertex in `G`.
-/
def lineGraph : SimpleGraph G.edgeSet where
  Adj e₁ e₂ := e₁ ≠ e₂ ∧ (e₁ ∩ e₂ : Set V).Nonempty
  symm.symm e₁ e₂ hadj := by rwa [ne_comm, Set.inter_comm]
```

## SimpleGraph.edgeFinset

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 59:

```lean
/-- The `edgeSet` of the graph as a `Finset`. -/
def edgeFinset : Finset (Sym2 V) :=
  Set.toFinset G.edgeSet
```

## SimpleGraph.maxDegree

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 496:

```lean
/-- The maximum degree of all vertices (and `0` if there are no vertices).
The key properties of this are given in `exists_maximal_degree_vertex`, `degree_le_maxDegree`
and `maxDegree_le_of_forall_degree_le`. -/
def maxDegree [DecidableRel G.Adj] : ℕ :=
  WithBot.unbotD 0 (univ.image fun v => G.degree v).max
```

## SimpleGraph.chromaticNumber

`Mathlib/Combinatorics/SimpleGraph/Coloring/Vertex.lean`, line 212:

```lean
/-- The chromatic number of a graph is the minimal number of colors needed to color it.
This is `⊤` (infinity) iff `G` isn't colorable with finitely many colors.

If `G` is colorable, then `ENat.toNat G.chromaticNumber` is the `ℕ`-valued chromatic number. -/
noncomputable def chromaticNumber : ℕ∞ := ⨅ n ∈ Set.ofPred G.Colorable, (n : ℕ∞)
```

## Sym2.Mem (membership `v ∈ e`)

`Mathlib/Data/Sym/Sym2.lean`, line 306:

```lean
/-- This is a predicate that determines whether a given term is a member of a term of the
symmetric square.  From this point of view, the symmetric square is the subtype of
cardinality-two multisets on `α`.
-/
protected def Mem (x : α) (z : Sym2 α) : Prop :=
  ∃ y : α, z = s(x, y)
```

## Fintype.card

`Mathlib/Data/Fintype/Card.lean`, line 40:

```lean
/-- `card α` is the number of elements in `α`, defined when `α` is a fintype. -/
def card (α) [Fintype α] : ℕ :=
  (@univ α _).card
```

## SimpleGraph.Subgraph

`Mathlib/Combinatorics/SimpleGraph/Subgraph.lean`, line 63:

```lean
/-- A subgraph of a `SimpleGraph` is a subset of vertices along with a restriction of the adjacency
relation that is symmetric and is supported by the vertex subset.  They also form a bounded lattice.

Thinking of `V → V → Prop` as `Set (V × V)`, a set of darts (i.e., half-edges), then
`Subgraph.adj_sub` is that the darts of a subgraph are a subset of the darts of `G`. -/
@[ext]
structure Subgraph {V : Type u} (G : SimpleGraph V) where
  /-- Vertices of the subgraph -/
  verts : Set V
  /-- Edges of the subgraph -/
  Adj : V → V → Prop
  adj_sub : ∀ {v w : V}, Adj v w → G.Adj v w
  edge_vert : ∀ {v w : V}, Adj v w → v ∈ verts
  symm : Std.Symm Adj := by aesop_graph
```

## SimpleGraph.Subgraph.edgeSet

`Mathlib/Combinatorics/SimpleGraph/Subgraph.lean`, line 250:

```lean
/-- The edge set of `G'` consists of a subset of edges of `G`. -/
def edgeSet (G' : Subgraph G) : Set (Sym2 V) := Sym2.fromRel G'.symm
```

## SimpleGraph.Subgraph.IsMatching

`Mathlib/Combinatorics/SimpleGraph/Matching.lean`, line 67:

```lean
/--
The subgraph `M` of `G` is a matching if every vertex of `M` is incident to exactly one edge in `M`.
We say that the vertices in `M.support` are *matched* or *saturated*.
-/
def IsMatching (M : Subgraph G) : Prop := ∀ ⦃v⦄, v ∈ M.verts → ∃! w, M.Adj v w
```

## SimpleGraph.IsVertexCover

`Mathlib/Combinatorics/SimpleGraph/VertexCover.lean`, line 36:

```lean
/-- `c` is a vertex cover of `G` if every edge in `G` is incident to at least one vertex in `c`. -/
def IsVertexCover (G : SimpleGraph V) (c : Set V) : Prop :=
  ∀ ⦃v w : V⦄, G.Adj v w → v ∈ c ∨ w ∈ c
```

## Set.ncard

`Mathlib/Data/Set/Card.lean`, line 613:

```lean
/-- The cardinality of `s : Set α` . Has the junk value `0` if `s` is infinite -/
noncomputable def ncard (s : Set α) : ℕ := ENat.toNat s.encard
```

## IsAntichain

`Mathlib/Order/Antichain.lean`, line 42:

```lean
/-- An antichain is a set such that no two distinct elements are related. -/
def IsAntichain (r : α → α → Prop) (s : Set α) : Prop :=
  s.Pairwise rᶜ
```

## IsChain

`Mathlib/Order/Preorder/Chain.lean`, line 51:

```lean
/-- A chain is a set `s` satisfying `x ≺ y ∨ x = y ∨ y ≺ x` for all `x y ∈ s`. -/
def IsChain (s : Set α) : Prop :=
  s.Pairwise fun x y => x ≺ y ∨ y ≺ x
```
