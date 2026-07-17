---
id: footer
title: Footer
layer: component
version: 1.0.0
status: stable
summary: A page-closing region with secondary navigation, legal, and trust information.
since: 0.3.0
updated: 2026-07-17
tags: [navigation, layout, wayfinding, legal]
aliases: [site-footer, page-footer, colophon]
usedBy: [landing-page, dashboard, pricing]
related: [navbar, sidebar]
maintainers: [brnrdog]
---

# Footer

## Intent

A footer closes the page with the content users look for at the end: secondary
navigation, legal and policy links, contact and social, and trust signals. It is
the conventional home for everything that doesn't belong in primary navigation but
should be reliably findable, anchoring the bottom of nearly every marketing and
content page.

## API

```json
{
  "props": [],
  "slots": [
    {"name":"brand","required":false},
    {"name":"links","required":true},
    {"name":"legal","required":false}
  ],
  "a11y": {"role":"contentinfo"},
  "states": ["default"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- A page needs a consistent closing region for secondary links, legal, and
  contact.
- Users expect a familiar place to find policies, sitemap, or social links.

**Avoid when**
- The screen is a focused app view or flow where a footer adds noise — omit it.

## Anatomy

- **Container** (required) — the page-closing region (a contentinfo landmark).
- **Link groups** (optional) — columns of categorized secondary links.
- **Brand / identity** (optional) — logo and a short descriptor.
- **Legal** (required) — copyright, terms, and privacy.
- **Utility** (optional) — newsletter signup, locale/currency, social links.

## States & behavior

- **Static** — primarily a navigation and information region.
- **Interactive utilities** — newsletter input, locale switcher, and links carry
  their own states.
- **Responsive collapse** — multi-column groups stack on small screens.

## Variants

- **Minimal** — logo, a few links, and legal.
- **Fat footer** — multiple grouped link columns plus utilities.
- **App footer** — a slim bar with version, status, and legal.

## Layout & responsiveness

On wide viewports, link groups sit in columns with brand and legal spanning the
width; on small screens the columns stack into a single readable column. Legal
and copyright typically anchor the very bottom.

## Accessibility

- **Semantics** — a contentinfo landmark; link groups use headings and lists so
  the structure is navigable.
- **Keyboard** — all links and utilities reachable in a logical order.
- **Screen reader** — announces the landmark and grouped navigation; utility
  controls follow their own patterns (input, button).
- **Contrast** — secondary text still meets contrast requirements.

## Content guidelines

- Group links under clear category headings.
- Keep legal links (privacy, terms) easy to find.
- Don't bury genuinely primary navigation only in the footer.

## Composition

```json
{
  "parts": [
    {"ref":"logo","slot":"brand"},
    {"ref":"link","slot":"links"},
    {"ref":"separator","slot":"legal"},
    {"ref":"input","slot":"links","note":"newsletter"},
    {"ref":"button","slot":"links"}
  ]
}
```

## Do / Don't

**Do**
- Group and label secondary links; keep legal reliably placed.
- Stack gracefully on small screens.

**Don't**
- Rely on the footer as the only path to important destinations.
- Overstuff it into an unscannable wall of links.

## References

- WCAG — Info and Relationships; landmark guidance for contentinfo.
