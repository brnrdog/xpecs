# Reativa examples (OCaml + Melange)

A small proof-of-concept: a handful of Xpecs specs implemented in **OCaml**
with [**reativa**](https://github.com/brnrdog/reativa) — the fine-grained,
signal-based UI library (the OCaml sibling of [Xote](https://xote.dev)) — as a
counterpart to the ReScript + Xote implementations in
[`../src/Examples.res`](../src/Examples.res).

The website renders both from the same design tokens: the **Preview** tab shows
the Xote version, the **Reativa** tab shows the version compiled from here.

## What's implemented

| Spec | Layer | Source |
| ---- | ----- | ------ |
| `button` | element | `Button` module in [`xpecs_reativa.mlx`](xpecs_reativa.mlx) |
| `badge` | element | `Badge` module |
| `alert` | component | `Alert` module (dismissible — demonstrates signals) |
| `cta-section` | block | `cta_example` (reactive email input) |

Everything is written in `.mlx` (JSX-for-OCaml, transformed by `mlx-pp`) over
`Reativa.View`. There is no virtual DOM: `View.mount` builds real DOM nodes
once and only the reactive regions update in place.

## How it plugs into the (ReScript/Vite) website

This is a **self-contained Melange workspace**, deliberately separate from the
ReScript/Vite build so the website keeps compiling without an OCaml toolchain:

1. `dune build @melange` compiles `xpecs_reativa.mlx` to ES modules under
   `_build/default/output/`.
2. `esbuild` bundles the emitted entry into
   [`../src/reativa.bundle.js`](../src/reativa.bundle.js) — a single ES module
   exporting `mount_example(specId, containerId)`, `example_ids`, and `built`.
3. The website ([`../src/ReativaExamples.res`](../src/ReativaExamples.res))
   imports that bundle and, when the **Reativa** tab is opened, imperatively
   mounts the example into a container `<div>` that Xote renders.

A checked-in **placeholder** bundle (`built = false`) stands in until you build,
so the site compiles out of the box and the Reativa tab shows a build hint.

## Building

Requires the OCaml toolchain. One-time setup:

```bash
opam switch create . 5.2.1 --deps-only   # or use an existing 5.1+ switch
opam install dune melange mlx
opam pin add reativa https://github.com/brnrdog/reativa.git
```

Then, from the `website/` directory:

```bash
npm run reativa        # dune build @melange + esbuild bundle
npm run dev            # start the site; open any of the specs above → "Reativa"
```

`npm run reativa` overwrites `../src/reativa.bundle.js` with the real compiled
output (`built = true`). Re-run it after editing `xpecs_reativa.mlx`.

> Note: `npm run reativa` is intentionally **not** part of `npm run build`/`dev`
> or CI — it needs opam/melange, which the rest of the website build does not.
