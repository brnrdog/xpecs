---
id: list
title: List
layer: component
version: 1.0.0
status: stable
summary: A vertical sequence of related items, each a compact row of content and actions.
since: 0.3.0
updated: 2026-07-17
tags: [collection, rows, content, navigation]
aliases: [list-view, item-list, feed]
usedBy: [dashboard, settings, sidebar]
related: [table, data-table, card]
maintainers: [brnrdog]
---

# List

## Intent

A list presents a set of related items as a vertical stack of rows, each showing
a compact summary and optional actions. It suits object-like items scanned top to
bottom — messages, files, people, notifications — where a single primary attribute
leads and a table's columns would be overkill.

## API

```json
{
  "responsive": {
    "container": true,
    "reflow": [
      {
        "pattern": "fluid",
        "note": "rows fill width"
      },
      {
        "at": "sm",
        "pattern": "truncate",
        "note": "secondary metadata truncates or hides"
      }
    ]
  },
  "props": [
    {"name":"interactive","type":"boolean","default":"false","description":"Whether rows are selectable/clickable."}
  ],
  "slots": [
    {"name":"item","required":true}
  ],
  "a11y": {"role":"list","keyboard":["ArrowUp","ArrowDown"]},
  "states": ["default","hover","selected"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Presenting a homogeneous collection scanned vertically, one item per row.
- Each item has a clear primary label plus light metadata and actions.

**Avoid when**
- Items are compared across many attributes — use a **table** / **data-table**.
- Items are rich, media-forward tiles — use **cards** in a grid.

## Anatomy

- **Container** (required) — the list region.
- **Items / rows** (required) — each with a primary label and optional supporting
  text, leading media (avatar/icon), trailing metadata, and actions.
- **Dividers** (optional) — separate rows.
- **Selection** (optional) — checkboxes for multi-select and bulk actions.
- **Section headers** (optional) — group items.
- **States** (required) — loading (skeleton rows), empty, and error.

## States & behavior

- **Static / interactive** — rows may be inert, navigable (whole row a link), or
  selectable.
- **Selected** — in selectable lists, with a bulk-action affordance.
- **Reorderable** (optional) — drag to reorder.
- **Loading / empty / error** — distinct, informative states.

## Variants

- **Simple** — label-only rows.
- **With media/metadata** — leading avatar/icon, trailing status or time.
- **Interactive** — navigable or selectable rows.
- **Grouped** — sectioned with headers.

## Layout & responsiveness

Rows span the container width with consistent internal padding and alignment
(leading media, flexible content, trailing meta/actions). On small screens,
trailing content may wrap beneath the primary label. Long lists scroll or paginate.

## Accessibility

- **Semantics** — a real list structure; interactive rows expose the correct link
  or button role and an accessible name.
- **Keyboard** — interactive and selectable rows are reachable and operable; a
  single clear target per row avoids fragmenting focus.
- **Screen reader** — announces item count and each row's meaningful content;
  loading/empty states are conveyed.
- **Selection** — selected state and bulk actions are announced.

## Content guidelines

- Lead with the most identifying attribute; keep supporting text brief.
- Provide a helpful empty state with a next step.

## Composition

```json
{
  "parts": [
    {"ref":"avatar","slot":"item"},
    {"ref":"badge","slot":"item"},
    {"ref":"button","slot":"item","note":"row action"},
    {"ref":"icon-button","slot":"item","note":"row action"},
    {"ref":"separator","slot":"item","note":"between rows"},
    {"ref":"checkbox","slot":"item","note":"selection"}
  ]
}
```

## Do / Don't

**Do**
- Keep one clear target per interactive row.
- Provide loading, empty, and error states.

**Don't**
- Force multi-attribute comparison into a list — use a table.
- Nest many competing controls in a single row.

## References

- WAI-ARIA Authoring Practices — List and Listbox guidance.
