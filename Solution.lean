/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib
public import Konig.Basic

/-!
# Proofs of the statements in `Challenge.lean`

The proofs are in `Konig/Basic.lean`: edges are coloured one at a time with the partial proper
edge colourings of the Vizing development (`LeanPool/Vizing/`), using a Kempe-chain swap whose
correctness rests on a parity argument in the bipartite graph.
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
