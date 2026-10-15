# Kőnig's theorems and Dilworth's theorem in Lean 4

Author and maintainer: **Juan Pablo Traverso Gianini**. Licence: Apache-2.0 (see `LICENSE`).

1. **Kőnig's edge-colouring theorem (1916).** A finite bipartite graph `G` has a proper edge
   colouring with `Δ(G)` colours; equivalently its chromatic index is `χ'(G) = Δ(G)`.
2. **Kőnig–Egerváry theorem (1931).** In a finite bipartite graph the maximum size of a matching
   equals the minimum size of a vertex cover.
3. **Dilworth's theorem (1950)** and **Mirsky's theorem (1971).** In a finite poset the maximum
   size of an antichain equals the minimum number of chains covering it, and the maximum size of
   a chain equals the minimum number of antichains covering it.

In Lean, the graph theorems are stated with Mathlib notions:
- bipartite means `G.Colorable 2`;
- edge colourings are colourings of the line graph `G.lineGraph`;
- matchings are Mathlib's `Subgraph.IsMatching`, vertex covers `SimpleGraph.IsVertexCover`, sizes
  `Set.ncard`;
- antichains and chains are Mathlib's `IsAntichain (· ≤ ·)` and `IsChain (· ≤ ·)`; a partition
  into `m` parts is a map to `Fin m`.

The compared theorems are:
- `KonigEdgeColouring.lineGraph_colorable`: `G.lineGraph.Colorable G.maxDegree`;
- `KonigEdgeColouring.lineGraph_chromaticNumber_eq`:
  `G.lineGraph.chromaticNumber = G.maxDegree`;
- `KonigEgervary.card_matching_le_card_vertexCover`: in any finite graph, every matching has at
  most as many edges as every vertex cover has vertices;
- `KonigEgervary.exists_matching_card_eq_vertexCover`: a finite bipartite graph has a matching
  and a vertex cover of the same size;
- `Dilworth.dilworth`: a finite poset has an antichain `A` and a partition into `|A|` chains;
- `Dilworth.mirsky`: a finite poset has a chain `C` and a partition into `|C|` antichains.

The audited statements are in [`Challenge.lean`](Challenge.lean), which imports only Mathlib. The
proofs are in [`Solution.lean`](Solution.lean) and in `Konig/` (`Basic.lean` for edge colouring,
`Egervary.lean`, `Dilworth.lean`).
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

**Kőnig–Egerváry.** Let `L` be one side of the bipartition and `S₀ ⊆ L` a set maximizing the
deficiency `d = |S| − |N(S)|`. Adding `d` dummy vertices adjacent to all of `L` makes Hall's
condition hold (Mathlib's Hall theorem), which yields a matching with `|L| − d` edges; the vertex
cover `(L \ S₀) ∪ N(S₀)` has exactly `|L| − d` vertices. Weak duality: distinct matching edges
need distinct cover vertices.

**Dilworth and Mirsky.** Dilworth's theorem is proved by Galvin's induction on the size of the
poset. For Mirsky's theorem, the height of an element (the largest size of a chain with that
element on top) strictly increases along `<`, so its fibres are antichains.

The partial-colouring and Kempe-chain infrastructure (`LeanPool/Vizing/`) is reused from the
author's formalization of Vizing's theorem:
- [jtraverso/vizing](https://github.com/jtraverso/vizing);
- Lean Pool commit `26ce45d3871e5560a8baffa4d49a8942b1d20a24`.

Only the modules it needs are included. Everything in `Konig/` is new.

## Sources

* D. Kőnig, *Über Graphen und ihre Anwendung auf Determinantentheorie und Mengenlehre*, Math.
  Ann. 77 (1916) 453–465, doi:10.1007/BF01456961.
* D. Kőnig, *Gráfok és mátrixok*, Mat. Fiz. Lapok 38 (1931) 116–119; J. Egerváry, *Matrixok
  kombinatorius tulajdonságairól*, Mat. Fiz. Lapok 38 (1931) 16–28.
* R. P. Dilworth, *A decomposition theorem for partially ordered sets*, Ann. of Math. 51 (1950)
  161–166, doi:10.2307/1969503.
* L. Mirsky, *A dual of Dilworth's decomposition theorem*, Amer. Math. Monthly 78 (1971)
  876–877, doi:10.1080/00029890.1971.11992886.
* F. Galvin, *A proof of Dilworth's chain decomposition theorem*, Amer. Math. Monthly 101 (1994)
  352–353, doi:10.1080/00029890.1994.11996954.

## Authorship and use of AI

The results and the proof routes were chosen by the author. The edge-colouring proof was written
with Claude (Claude Code); the Kőnig–Egerváry, Dilworth and Mirsky proofs were produced by
Harmonic's Aristotle from statements and proof plans written with Claude, and audited and rebuilt
locally. Everything is checked mechanically with Lean. See `formalization.yaml`.

## Building

Lean `v4.35.0-rc3`, Mathlib `c55e6e786f49471c72fbddbec5415808896aec1e`:

```bash
lake exe cache get
lake build
```
