/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib

/-!
# Kőnig's theorems and Dilworth's theorem

**Kőnig's edge-colouring theorem (1916).** A finite bipartite graph `G` has a proper edge colouring with `Δ(G)`
colours, i.e. its line graph is `Δ(G)`-colourable (`KonigEdgeColouring.lineGraph_colorable`);
since the edges at a vertex of maximum degree need distinct colours, its chromatic index is
exactly `Δ(G)` (`KonigEdgeColouring.lineGraph_chromaticNumber_eq`).

**Kőnig–Egerváry theorem (1931).** In a finite bipartite graph the maximum size of a matching
equals the minimum size of a vertex cover: there are a matching and a vertex cover of the same
size (`KonigEgervary.exists_matching_card_eq_vertexCover`), and every matching is at most as large
as every vertex cover (`KonigEgervary.card_matching_le_card_vertexCover`, any finite graph).

**Dilworth's theorem (1950) and Mirsky's theorem (1971).** A finite poset has an antichain `A` and
a partition into `|A|` chains (`Dilworth.dilworth`), and a chain `C` and a partition into `|C|`
antichains (`Dilworth.mirsky`); a partition into `m` parts is a map to `Fin m`.

A graph is bipartite when it is 2-colourable (`G.Colorable 2`); edge colourings are colourings of
the line graph `G.lineGraph`, whose vertices are the edges of `G`, adjacent when they share a
vertex.

The Mathlib definitions used in these statements are reproduced verbatim, with file and line at
the pinned Mathlib revision, in `MATHLIB_DEFINITIONS.md` at the root of this repository.
-/

@[expose] public section

namespace KonigEdgeColouring

/-- **Kőnig's edge-colouring theorem.** The line graph of a finite bipartite graph is
`Δ(G)`-colourable. -/
theorem lineGraph_colorable {V : Type*} [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj]
    (h : G.Colorable 2) : G.lineGraph.Colorable G.maxDegree := by
  sorry

/-- **Kőnig's edge-colouring theorem**, chromatic-index form: `χ'(G) = Δ(G)` for a finite
bipartite graph `G`. -/
theorem lineGraph_chromaticNumber_eq {V : Type*} [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] (h : G.Colorable 2) :
    G.lineGraph.chromaticNumber = G.maxDegree := by
  sorry

end KonigEdgeColouring

open SimpleGraph

namespace KonigEgervary

/-- **Weak duality.** A matching has at most as many edges as a vertex cover has vertices. -/
theorem card_matching_le_card_vertexCover {V : Type*} [Finite V] {G : SimpleGraph V}
    {M : G.Subgraph} (hM : M.IsMatching) {C : Set V} (hC : G.IsVertexCover C) :
    M.edgeSet.ncard ≤ C.ncard := by
  sorry

/-- **Kőnig–Egerváry (1931).** A finite bipartite graph has a matching and a vertex cover of the
same size. -/
theorem exists_matching_card_eq_vertexCover {V : Type*} [Finite V] (G : SimpleGraph V)
    (h : G.Colorable 2) :
    ∃ (M : G.Subgraph) (C : Set V), M.IsMatching ∧ G.IsVertexCover C ∧
      M.edgeSet.ncard = C.ncard := by
  sorry

end KonigEgervary

namespace Dilworth

/-- **Dilworth's theorem (1950).** A finite poset has an antichain `A` and a partition into `|A|`
chains. -/
theorem dilworth {α : Type*} [PartialOrder α] [Finite α] :
    ∃ A : Finset α, IsAntichain (· ≤ ·) (A : Set α) ∧
      ∃ c : α → Fin A.card, ∀ i, IsChain (· ≤ ·) {x | c x = i} := by
  sorry

/-- **Mirsky's theorem (1971).** A finite poset has a chain `C` and a partition into `|C|`
antichains. -/
theorem mirsky {α : Type*} [PartialOrder α] [Finite α] :
    ∃ C : Finset α, IsChain (· ≤ ·) (C : Set α) ∧
      ∃ c : α → Fin C.card, ∀ i, IsAntichain (· ≤ ·) {x | c x = i} := by
  sorry

end Dilworth
