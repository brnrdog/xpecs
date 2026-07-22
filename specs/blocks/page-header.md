---
id: page-header
title: Page Header
layer: block
version: 1.0.0
status: stable
summary: A page-opening band that names the current view and offers its primary actions.
since: 0.8.0
updated: 2026-07-22
tags: [application, section, header, navigation, actions]
aliases: [page-title, view-header, screen-header, content-header]
usedBy: [dashboard, settings]
related: [navbar, breadcrumb, toolbar, tabs]
maintainers: [brnrdog]
implementation: PageHeader.res
---

# Page Header

## Intent

A page header opens every application view with the same three answers: where am
I, what is this page, and what can I do here. It carries the page title (the
view's one `h1`), optional wayfinding back up the hierarchy, a line of context,
and the view's primary actions — so users orient instantly and the actions that
matter most are always in the same, predictable place.

Where a **navbar** anchors the whole product and a **toolbar** operates on the
content below it, the page header names and frames *this* view.

## API

```json
{
  "responsive": {
    "container": true,
    "minTarget": "44px",
    "reflow": [
      {
        "at": "sm",
        "pattern": "stack",
        "note": "the title row and the actions cluster stack; actions align start"
      },
      {
        "pattern": "truncate",
        "note": "a long title truncates rather than wrapping the actions away"
      }
    ]
  },
  "props": [],
  "slots": [
    {"name":"breadcrumb","required":false},
    {"name":"title","required":true},
    {"name":"description","required":false},
    {"name":"actions","required":false},
    {"name":"tabs","required":false}
  ],
  "a11y": {"announces":["page title as the view's top-level heading"]},
  "states": ["default"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Opening any application view — dashboards, lists, detail pages, settings
  sections — that needs a title, context, and page-level actions.

**Avoid when**
- The screen is a marketing or landing page — open with a **hero** instead.
- The "header" would only repeat the navbar's product name with nothing
  view-specific to add.

## Anatomy

- **Breadcrumb** (optional) — the trail back up the hierarchy, above the title.
- **Title** (required) — the view's name; the page's single top-level heading.
- **Description** (optional) — one line of context under the title.
- **Actions** (optional) — the view's primary and secondary actions, aligned
  opposite the title.
- **Tabs / sub-navigation** (optional) — sections within the view, along the
  header's bottom edge.
- **Meta** (optional) — status badges or key facts beside the title.

## States & behavior

- **Default** — static framing; the actions carry the interactivity.
- **Loading** (optional) — title and meta may show skeletons while the view
  resolves, keeping the layout stable.
- **Sticky** (optional) — the header (or a condensed version) can pin to the top
  while the view scrolls, keeping title and actions reachable.

## Variants

- **Title only** — the minimal form for simple views.
- **With breadcrumb** — hierarchical apps where "up" matters.
- **With actions** — list/detail views with a clear primary action.
- **With tabs** — a view divided into sections (settings, detail pages).

## Layout & responsiveness

Title (with breadcrumb above and description below) aligns to the reading edge;
actions align to the opposite edge on the same row. On narrow containers the two
groups stack — title block first, actions beneath it — and long titles truncate
with their full text available. Tabs, when present, run along the bottom edge and
scroll horizontally rather than wrapping.

## Accessibility

- **Semantics** — the title is the view's single `h1`; breadcrumb and tabs
  follow their own specs' navigation semantics.
- **Keyboard** — breadcrumb links, actions, and tabs are reachable in reading
  order: breadcrumb → title-adjacent meta → actions → tabs.
- **Screen reader** — the page title is what the view announces on navigation;
  truncated titles expose their full text as the accessible name.
- **Target size** — action controls preserve the minimum pointer target.

## Content guidelines

- Title names the view in the user's vocabulary — short, no product-name prefix.
- Description is one sentence of orientation, not documentation.
- Cap visible actions at two or three; overflow the rest into a menu.

## Composition

```json
{
  "parts": [
    {"ref":"breadcrumb","slot":"breadcrumb"},
    {"ref":"typography","slot":"title","note":"the h1"},
    {"ref":"badge","slot":"title","note":"status meta beside the title"},
    {"ref":"button","slot":"actions","props":{"variant":"primary"}},
    {"ref":"button-group","slot":"actions"},
    {"ref":"tabs","slot":"tabs"}
  ]
}
```

## Do / Don't

**Do**
- Keep the title, description, and actions in the same place on every view.
- Make the title the view's real `h1` and the anchor of its heading order.

**Don't**
- Stack multiple competing primary actions in the header.
- Restate the navbar's brand or section name as the page title.

## References

- Nielsen Norman Group — page titles and wayfinding.
- WAI-ARIA Authoring Practices — breadcrumb and tabs patterns (for the composed
  parts).
