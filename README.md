# Kőnig's edge-colouring theorem in Lean 4

Author and maintainer: **Juan Pablo Traverso Gianini**. Licence: Apache-2.0 (see `LICENSE`).

**Theorem (Kőnig, 1916).** A finite bipartite graph `G` has a proper edge colouring with `Δ(G)`
colours; equivalently its chromatic index is `χ'(G) = Δ(G)`.

In Lean, the theorem is stated with Mathlib notions:
- bipartite means `G.Colorable 2`;
- edge colourings are colourings of the line graph `G.lineGraph`.

The two compared theorems are:
- `KonigEdgeColouring.lineGraph_colorable`: `G.lineGraph.Colorable G.maxDegree`;
- `KonigEdgeColouring.lineGraph_chromaticNumber_eq`:
  `G.lineGraph.chromaticNumber = G.maxDegree`.

The audited statements are in [`Challenge.lean`](Challenge.lean), which imports only Mathlib. The
proofs are in [`Solution.lean`](Solution.lean) and [`Konig/Basic.lean`](Konig/Basic.lean).
Supporting files:
- [`comparator.json`](comparator.json) names the compared theorems;
- [`MATHLIB_DEFINITIONS.md`](MATHLIB_DEFINITIONS.md) reproduces verbatim the Mathlib definitions
  used;
- [`formalization.yaml`](formalization.yaml) records provenance, sources and process.

## How the proof goes

Edges are coloured one at a time with partial proper edge colourings. To colour an uncoloured
edge `xy`:
1. Take a colour `a` free at `x` and a colour `b` free at `y`. Both exist because `xy` is
   uncoloured and there are `Δ(G)` colours.
2. If `a` is free at `y`, colour `xy` with `a`.
3. Otherwise, swap `a` and `b` on the `a/b` Kempe component of `y`. Since `b` is free at `y`, the
   colours alternate along every Kempe path ending at `y`, and the edge farthest from `y` has
   colour `a` exactly when the path has odd length. A Kempe path from `y` to `x` would have odd
   length because `G` is bipartite, contradicting that `a` is free at `x`. So `x` stays outside
   the component, and after the swap `a` is free at both ends.

The lower bound `Δ(G) ≤ χ'(G)` holds because the edges at a vertex of maximum degree are pairwise
adjacent in the line graph.

The partial-colouring and Kempe-chain infrastructure (`LeanPool/Vizing/`) is reused from the
author's formalization of Vizing's theorem:
- [jtraverso/vizing](https://github.com/jtraverso/vizing);
- Lean Pool commit `26ce45d3871e5560a8baffa4d49a8942b1d20a24`.

Only the modules it needs are included. The Kőnig step and the lower bound in `Konig/Basic.lean`
are new.

## Source

* D. Kőnig, *Über Graphen und ihre Anwendung auf Determinantentheorie und Mengenlehre*, Math.
  Ann. 77 (1916) 453–465, doi:10.1007/BF01456961.

## Authorship and use of AI

The result and the proof route were chosen by the author. The Lean code was written with AI
assistance (Claude in Claude Code) and checked mechanically with Lean. See `formalization.yaml`.

## Building

Lean `v4.35.0-rc3`, Mathlib `c55e6e786f49471c72fbddbec5415808896aec1e`:

```bash
lake exe cache get
lake build
```
