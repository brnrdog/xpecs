# Xpecs

A collection of **User Experience (UX) Specs** — reusable, technology-agnostic
definitions of UI patterns written in words, meant to be used as a shared
reference for design and implementation by both **humans and AI agents**. They span
the full experience: from the smallest interface element up to complete pages and
flows.

> An spec is an original model, perfect example, or universal pattern upon
> which other things are copied or based. From the Greek _archein_ (to begin)
> and _typos_ (a mold or pattern).

In this repository an spec describes **what** a pattern _is_, **when** to
use it, how it is **composed**, how it **behaves**, and how it stays
**accessible** — without prescribing a framework, styling approach, or a single
visual design. That makes each spec portable across projects, contexts,
and tech stacks while keeping the meaning of the pattern consistent everywhere.

---

## Why this exists

Design systems and component libraries get re-invented on every project and
every stack. The visual skin and the framework change, but the underlying
_pattern_ — what a Button is, what a Navbar must do, what a Landing Page is
for — does not. This repository captures those stable patterns once, so they
can be:

- **Reused** across projects and stacks (React, Vue, SwiftUI, design tools, …).
- **Referenced** by AI agents as a source of truth when generating UI.
- **Composed** from small units into components and full pages.
- **Versioned** so changes are explicit and traceable.

An spec is a _specification of intent and structure_, not an
implementation. Each project maps specs onto its own tokens, framework,
and visual language.

---

## Taxonomy: layers

Specs are organized into **layers**, from the smallest unit to the
complete experience. The structure is intentionally flat: one directory per
layer, one Markdown file per spec.

| Layer          | Directory                | What it is | Examples |
| -------------- | ------------------------ | ---------- | -------- |
| **Element**    | `specs/elements/`   | An indivisible UI unit with a single responsibility. | button, input, badge, avatar, icon, checkbox, spinner |
| **Component**  | `specs/components/` | A self-contained pattern composed of elements. | navbar, card, form, modal, data-table, tabs |
| **Page**       | `specs/pages/`      | A full-screen spec composing components toward one goal. | landing-page, dashboard, sign-in, pricing, settings |
| **Flow**       | `specs/flows/`      | A sequence of pages/steps toward an outcome (a multi-page journey). | authentication, onboarding, checkout |

The layer of an spec is declared in its metadata (`layer:`) **and**
reflected by the directory it lives in. Keeping both in sync is the only
structural rule.

### File & naming conventions

- One spec per file: `specs/<layer-plural>/<id>.md`.
- `id` is a lowercase, kebab-case slug and must be unique across the whole
  collection (e.g. `button`, `data-table`, `landing-page`).
- The `id` in the metadata must match the filename.

---

## The spec document

Every spec follows the **same document pattern** so they are predictable
for both readers and machines. A document has two parts:

1. **Metadata** — a YAML frontmatter block at the top (see
   [`schema/spec.schema.json`](schema/spec.schema.json)).
2. **Body** — a fixed set of sections (see
   [`templates/SPEC_TEMPLATE.md`](templates/SPEC_TEMPLATE.md)).

### Metadata fields

| Field         | Required | Description |
| ------------- | :------: | ----------- |
| `id`          | ✅ | Unique kebab-case slug; matches the filename. |
| `title`       | ✅ | Human-readable name. |
| `layer`       | ✅ | `element` \| `component` \| `page` \| `flow`. |
| `version`     | ✅ | Semantic version **of this spec** (independent of the collection). |
| `status`      | ✅ | `draft` \| `stable` \| `deprecated`. |
| `summary`     | ✅ | One-sentence description of intent. |
| `since`       | ✅ | Collection version in which the spec first appeared. |
| `updated`     | ✅ | ISO date (`YYYY-MM-DD`) of the last meaningful change. |
| `tags`        |   | Free-form keywords for discovery. |
| `aliases`     |   | Alternative names people search for. |
| `composedOf`  |   | `id`s of specs this one is built from. |
| `usedBy`      |   | `id`s of specs that commonly include this one. |
| `related`     |   | `id`s of adjacent specs worth comparing. |
| `maintainers` |   | People accountable for the spec. |

`composedOf` / `usedBy` turn the collection into a **linked graph**: you can
walk from a page down to the elements it relies on, or from an element up to
everything that uses it.

### Body sections

The body is always the same ordered set of sections. Sections that do not apply
to a given spec are kept with a short _“Not applicable”_ note rather than
removed, so the shape stays constant.

1. **Intent** — the problem it solves and the value it provides.
2. **When to use / When not to use** — selection guidance and alternatives.
3. **Anatomy** — the structural parts (slots) that make it up.
4. **States & behavior** — interaction states and dynamic behavior.
5. **Variants** — named, meaningful variations.
6. **Layout & responsiveness** — arrangement and how it adapts across sizes.
7. **Accessibility** — keyboard, screen-reader, focus, and contrast requirements.
8. **Content guidelines** — voice, labels, and copy rules.
9. **Composition** — what it is composed of and what composes it.
10. **Do / Don't** — concise usage guidance.
11. **References** — prior art and further reading.

---

## Versioning

The collection uses **[Semantic Versioning](https://semver.org/)** at two levels.

### Collection version

Tracked in [`VERSION`](VERSION), [`package.json`](package.json), and
[`CHANGELOG.md`](CHANGELOG.md).

- **MAJOR** — a breaking change to the document pattern or metadata schema, or
  the removal of an spec.
- **MINOR** — a new spec is added, or a backward-compatible addition to the
  template/schema.
- **PATCH** — clarifications, fixes, and content refinements that don't change
  the structure.

### Per-spec version

Each spec carries its own `version` in metadata, using the same rules
scoped to that single document:

- **MAJOR** — the meaning/anatomy changes in a way that would break existing
  implementations.
- **MINOR** — a new variant, state, or section content is added compatibly.
- **PATCH** — wording and clarity fixes.

The `status` field describes lifecycle: `draft` (in progress), `stable` (safe to
build on), `deprecated` (kept for reference, avoid in new work).

---

## Using specs in a project

Specs are stack-agnostic on purpose. To adopt them:

1. **Pick** the specs you need (start from [`INDEX.md`](INDEX.md)).
2. **Map** each one onto your design tokens and framework — the spec tells
   you the required parts, states, and accessibility contract; your project
   decides the visual language and code.
3. **Point your AI agents at it.** Because the format is consistent and
   machine-readable, an agent can read an spec and scaffold a compliant
   implementation for your stack, then you review against the same document.

Consume the collection however suits you: git submodule, vendored copy, or the
published package metadata in `package.json`.

---

## Repository layout

```
ux-archetypes/
├── README.md                     # this file
├── CONTRIBUTING.md               # how to add or change an spec
├── CHANGELOG.md                  # semver history of the collection
├── VERSION                       # current collection version
├── package.json                  # version + distribution metadata
├── INDEX.md                      # registry of all specs
├── schema/
│   └── spec.schema.json     # JSON Schema for the frontmatter metadata
├── tokens/
│   └── tokens.json               # shared design tokens (W3C DTCG format)
├── templates/
│   └── SPEC_TEMPLATE.md     # canonical document pattern to copy
└── specs/
    ├── elements/                 # indivisible units (button, input, badge, …)
    ├── components/               # composed patterns (navbar, card, dialog, …)
    └── pages/                    # full-screen experiences (landing-page, …)
```

See [`INDEX.md`](INDEX.md) for the full, current list of specs.

---

## Design tokens

Specs describe _structure and behavior_ and avoid pixels and hues on
purpose. The concrete, shared values — color, type, spacing, radius, elevation,
motion — live in [`tokens/`](tokens/) as
[`tokens.json`](tokens/tokens.json), authored in the standard
**[W3C Design Tokens (DTCG) format](https://www.w3.org/community/design-tokens/)**.
Define them once and every implementation stays visually consistent; the
[website](website/) generates its whole theme from this file. See
[`tokens/README.md`](tokens/README.md).

## Website

An interactive catalogue lives in [`website/`](website/): it lists every
spec and renders a **live example** of each, built with Vite, ReScript,
[Xote](https://xote.dev), and Tailwind CSS in a monochrome theme, themed from
the shared [design tokens](tokens/). See [`website/README.md`](website/README.md)
to run it.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). In short: copy the template, fill in
the metadata and every section, keep the `id`/filename/layer in sync, and bump
the versions and changelog.

## License

[MIT](LICENSE).
