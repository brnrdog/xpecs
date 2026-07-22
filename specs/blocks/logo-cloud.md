---
id: logo-cloud
title: Logo Cloud
layer: block
version: 1.0.0
status: stable
summary: A band of customer or partner logos that lends credibility at a glance.
since: 0.8.0
updated: 2026-07-22
tags: [marketing, landing, section, social-proof, trust]
aliases: [logo-wall, trust-bar, brand-strip, customer-logos]
usedBy: [landing-page]
related: [testimonial, hero, carousel]
maintainers: [brnrdog]
implementation: LogoCloud.res
---

# Logo Cloud

## Intent

A logo cloud borrows trust: a quiet strip of recognizable customer or partner
marks that says "companies you know rely on this" without a word of copy. It
works by recognition, not reading — placed right after the hero, it answers the
credibility question in the second before a visitor decides whether to keep
scrolling. Where a **testimonial** proves depth with one voice, a logo cloud
proves breadth with many.

## API

```json
{
  "responsive": {
    "container": true,
    "reflow": [
      {
        "pattern": "wrap",
        "note": "the logo row wraps onto additional lines as width decreases"
      }
    ]
  },
  "props": [],
  "slots": [
    {"name":"heading","required":false},
    {"name":"logos","required":true}
  ],
  "states": ["default"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Recognizable customers, partners, or press can vouch for the product early on
  a marketing page.

**Avoid when**
- The logos aren't recognizable to the audience — unknown marks add noise, not
  trust; use a **testimonial** with a concrete outcome instead.
- You lack permission to use the marks.

## Anatomy

- **Heading** (optional) — a short qualifier ("Trusted by teams at").
- **Logos** (required) — four to eight marks, visually equalized in size and
  weight.
- **Links** (optional) — each mark may link to a case study.

## States & behavior

- **Static** — a presentational band; the common default.
- **Linked** — marks navigate to case studies or customer stories.
- **Scrolling** (optional) — a slow, pausable marquee when there are many marks;
  motion respects reduced-motion preferences.

## Variants

- **Inline strip** — one quiet row, right under the hero.
- **Grid** — two or three rows for a larger set.
- **Marquee** — continuously scrolling strip for many logos.

## Layout & responsiveness

Marks sit on one centered row with even spacing, optically normalized so no
brand dominates. As the container narrows the row wraps to additional lines;
marks keep a consistent size rather than shrinking to fit. The band stays
visually quieter than the content around it — often desaturated to a single
tone.

## Accessibility

- **Media** — each mark carries its company name as alternative text; purely
  decorative treatments still name the companies for assistive tech.
- **Links** — linked marks expose the company name (and destination) as the
  accessible name, with visible focus.
- **Motion** — marquee variants pause on hover/focus and honor
  `prefers-reduced-motion`.
- **Contrast** — desaturated marks remain distinguishable from the background.

## Content guidelines

- Curate for recognition: fewer well-known marks beat many obscure ones.
- Keep the heading factual and modest ("Trusted by", not superlatives).
- Get written permission for every mark you show.

## Composition

```json
{
  "parts": [
    {"ref":"typography","slot":"heading"},
    {"ref":"logo","slot":"logos"},
    {"ref":"link","slot":"logos","note":"linked marks"}
  ]
}
```

## Do / Don't

**Do**
- Equalize the marks' visual weight so the band reads as one unit.
- Lead with the most recognizable brands.

**Don't**
- Let the band compete with the hero — it supports, quietly.
- Fake or imply endorsements you don't have.

## References

- Nielsen Norman Group — credibility and social proof on landing pages.
