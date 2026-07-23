---
"@xpecs/reativa": minor
---

Add `@xpecs/reativa` — the ReasonML/OCaml (reativa + Melange) sibling of
`@xpecs/xote`, as its own package.

- Implements the same set `@xpecs/xote` covers — 22 elements, 8 components, and
  7 blocks — in `.mlx` (JSX-for-OCaml) over `Reativa.View`, styled against
  `@xpecs/tokens`, with the same behaviour and accessibility semantics as the
  Xote components.
- Enum prop types (`variant`, `size`, …) are generated from the specs' `## API`
  contracts into `src/Contracts.ml` by `npm run contracts`, so the OCaml
  compiler enforces that the implementation can't drift from the spec — the same
  guarantee `@xpecs/xote` has.
- `src/Registry.mlx` renders one live example per spec and exports the JS surface
  the website's **Reativa** preview consumes (`mount_example`, `example_ids`,
  `built`). The website's example block now has two tab strips: one picks the
  view (Preview / Playground / Code) and one picks the implementation rendered in
  the preview (**Xote** or **Reativa**).
