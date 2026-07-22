---
id: steps
title: Steps
layer: block
version: 1.0.0
status: stable
summary: An ordered sequence of numbered items that explains how a process works.
since: 0.8.0
updated: 2026-07-22
tags: [marketing, landing, section, onboarding, process]
aliases: [how-it-works, process, numbered-steps, step-list]
usedBy: [landing-page]
related: [feature-grid, hero, list]
maintainers: [brnrdog]
implementation: Steps.res
---

# Steps

## Intent

A steps section makes a process feel easy by showing it in order: sign up,
connect, done. Each step pairs a number (or icon) with a short title and one
line of explanation, connected visually so the sequence reads as one path.
Where a **feature-grid** says *what you get* in any order, steps say *what
happens next* — the order is the message, and a short list of steps is itself
the claim that getting started is simple.

## API

```json
{
  "responsive": {
    "container": true,
    "reflow": [
      {
        "at": "md",
        "pattern": "stack",
        "note": "horizontal steps stack vertically; connectors turn vertical"
      }
    ]
  },
  "props": [
    {"name":"orientation","type":"enum","values":["horizontal","vertical"],"default":"horizontal","description":"Whether the sequence runs across the container or down it."}
  ],
  "slots": [
    {"name":"heading","required":false},
    {"name":"steps","required":true}
  ],
  "states": ["default"],
  "tokens": ["color.neutral.*", "color.action.*"]
}
```

## When to use / When not to use

**Use when**
- Explaining a genuinely sequential process — how onboarding, setup, or the
  product's core loop works — in three to five steps.

**Avoid when**
- The items have no meaningful order — use a **feature-grid**.
- The user is *performing* the steps in-product — that's a wizard/stepper
  interaction, not this explanatory section.

## Anatomy

- **Heading** (optional) — frames the process ("How it works").
- **Step items** (required) — three to five, each with:
  - **Marker** — the step number or an icon.
  - **Title** — a short imperative or outcome.
  - **Description** — one or two lines of detail.
- **Connectors** (optional) — lines or arrows tying the markers into a path.
- **Action** (optional) — a call to action to start step one.

## States & behavior

- **Static** — presentational; the common marketing default.
- **Linked** (optional) — a step links to docs or detail about that stage.

## Variants

- **Horizontal** — steps run across the section; the default on wide screens.
- **Vertical** — steps run down, markers on a shared line; suits longer
  descriptions and timelines.
- **Icon-led** — icons replace numbers when each step has a strong visual verb.

## Layout & responsiveness

Horizontal steps share the row equally, markers aligned on one axis with
connectors between them. As the container narrows the sequence stacks into the
vertical form — markers on a shared left line, text beside them — so the path
stays continuous rather than wrapping into a grid that breaks the order.

## Accessibility

- **Semantics** — the sequence is an ordered list; numbering comes from the
  list semantics, not just the visuals.
- **Reading order** — matches the sequence at every width and orientation.
- **Markers & connectors** — decorative; the order is conveyed by the list, so
  connectors are hidden from assistive tech.
- **Links** — linked steps expose the step title as the accessible name.

## Content guidelines

- Three to five steps; if you need more, the story is too detailed for this
  section.
- Title each step with a verb ("Connect your repo"), one short line of
  description.
- Make the last step the payoff, not more work.

## Composition

```json
{
  "parts": [
    {"ref":"typography","slot":"heading"},
    {"ref":"icon","slot":"steps","note":"icon-led markers"},
    {"ref":"separator","slot":"steps","note":"connectors"},
    {"ref":"button","slot":"steps","note":"optional start-here action"}
  ]
}
```

## Do / Don't

**Do**
- Let the small count carry the message: this is easy.
- Keep every step parallel in voice and length.

**Don't**
- Number things that aren't actually sequential.
- Turn step descriptions into documentation.

## References

- Nielsen Norman Group — instructional content and process visualization.
