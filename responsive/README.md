# Responsive patterns

How a spec restructures as available width changes is a **contract**, not
an afterthought — the same way behavior is captured as [traits](../traits/) and
color/spacing as [tokens](../tokens/). This directory holds the shared
vocabulary of **reflow patterns** that specs reference instead of
re-describing responsiveness in prose.

## The pieces

- **Breakpoints** live in [`tokens/tokens.json`](../tokens/tokens.json) under
  `breakpoint.*` (`sm` 40rem, `md` 48rem, `lg` 64rem, `xl` 80rem, `2xl` 96rem).
  They give "small screen" a concrete, shared meaning.
- **Patterns** live in [`patterns.json`](patterns.json) — a fixed vocabulary of
  the ways a layout adapts (`stack`, `reflow-columns`, `collapse-to-menu`,
  `drawer`, `to-sheet`, `horizontal-scroll`, `reflow-to-cards`, `reposition`,
  `wrap`, `truncate`, `hide-secondary`, `fluid`).
- **The contract** is the `responsive` block inside each spec's `## API`
  section (schema: [`schema/api.schema.json`](../schema/api.schema.json)):

  ```json
  "responsive": {
    "container": true,
    "minTarget": "44px",
    "reflow": [
      { "at": "lg", "pattern": "horizontal-scroll", "note": "keeps columns; scrolls with a frozen key column" },
      { "at": "sm", "pattern": "reflow-to-cards", "note": "rows become stacked label/value cards" }
    ]
  }
  ```

  - `container` — the spec adapts to its container's width, not just the
    viewport (so it behaves in a narrow column on a wide screen).
  - `minTarget` — the smallest pointer target to preserve at any width.
  - `reflow[]` — each adaptation names a `pattern` from the vocabulary and,
    when it has a fixed threshold, the breakpoint `at` which it applies. Fluid,
    wrap, reposition, and truncate typically omit `at` (they're continuous).
    A primitive that keeps its shape everywhere uses `"reflow": []`.

## Guarantees

`npm run conformance:responsive` (in `website/`) validates that every spec
with an API contract declares `responsive`, that every `pattern` is in the
vocabulary, and that every `at` resolves to a real breakpoint token — so the
responsive contract can't drift. The website renders it on each spec's
detail page, and the Agent Skill ships it in `reference/specs.json` plus
the vocabulary in `reference/responsive-patterns.json`.
