/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib

/-!
# Kőnig's edge-colouring theorem

**Theorem (Kőnig, 1916).** A finite bipartite graph `G` has a proper edge colouring with `Δ(G)`
colours, i.e. its line graph is `Δ(G)`-colourable (`KonigEdgeColouring.lineGraph_colorable`);
since the edges at a vertex of maximum degree need distinct colours, its chromatic index is
exactly `Δ(G)` (`KonigEdgeColouring.lineGraph_chromaticNumber_eq`).

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
