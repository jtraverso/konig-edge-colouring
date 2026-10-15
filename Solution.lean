/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib
public import Konig.Basic
public import Konig.Egervary
public import Konig.Dilworth

/-!
# Proofs of the statements in `Challenge.lean`

The Kőnig–Egerváry theorem is proved in `Konig/Egervary.lean` (Hall's theorem with deficiency),
Dilworth's and Mirsky's theorems in `Konig/Dilworth.lean` (Galvin's induction; the height
function). The edge-colouring theorem is proved in `Konig/Basic.lean`: edges are coloured one
at a time with the partial proper edge colourings of the Vizing development (`LeanPool/Vizing/`),
using a Kempe-chain swap whose correctness rests on a parity argument in the bipartite graph.
-/

@[expose] public section

namespace KonigEdgeColouring

/-- **Kőnig's edge-colouring theorem.** The line graph of a finite bipartite graph is
`Δ(G)`-colourable. -/
theorem lineGraph_colorable {V : Type*} [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj]
    (h : G.Colorable 2) : G.lineGraph.Colorable G.maxDegree :=
  Konig.lineGraph_colorable_of_colorable_two G h

/-- **Kőnig's edge-colouring theorem**, chromatic-index form: `χ'(G) = Δ(G)` for a finite
bipartite graph `G`. -/
theorem lineGraph_chromaticNumber_eq {V : Type*} [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] (h : G.Colorable 2) :
    G.lineGraph.chromaticNumber = G.maxDegree :=
  Konig.lineGraph_chromaticNumber_of_colorable_two G h

end KonigEdgeColouring

open SimpleGraph

namespace KonigEgervary

/-- **Weak duality.** A matching has at most as many edges as a vertex cover has vertices. -/
theorem card_matching_le_card_vertexCover {V : Type*} [Finite V] {G : SimpleGraph V}
    {M : G.Subgraph} (hM : M.IsMatching) {C : Set V} (hC : G.IsVertexCover C) :
    M.edgeSet.ncard ≤ C.ncard :=
  Konig.Egervary.card_matching_le_card_vertexCover hM hC

/-- **Kőnig–Egerváry (1931).** A finite bipartite graph has a matching and a vertex cover of the
same size. -/
theorem exists_matching_card_eq_vertexCover {V : Type*} [Finite V] (G : SimpleGraph V)
    (h : G.Colorable 2) :
    ∃ (M : G.Subgraph) (C : Set V), M.IsMatching ∧ G.IsVertexCover C ∧
      M.edgeSet.ncard = C.ncard :=
  Konig.Egervary.exists_matching_card_eq_vertexCover G h

end KonigEgervary

namespace Dilworth

/-- **Dilworth's theorem (1950).** A finite poset has an antichain `A` and a partition into `|A|`
chains. -/
theorem dilworth {α : Type*} [PartialOrder α] [Finite α] :
    ∃ A : Finset α, IsAntichain (· ≤ ·) (A : Set α) ∧
      ∃ c : α → Fin A.card, ∀ i, IsChain (· ≤ ·) {x | c x = i} :=
  Konig.Poset.dilworth

/-- **Mirsky's theorem (1971).** A finite poset has a chain `C` and a partition into `|C|`
antichains. -/
theorem mirsky {α : Type*} [PartialOrder α] [Finite α] :
    ∃ C : Finset α, IsChain (· ≤ ·) (C : Set α) ∧
      ∃ c : α → Fin C.card, ∀ i, IsAntichain (· ≤ ·) {x | c x = i} :=
  Konig.Poset.mirsky

end Dilworth
