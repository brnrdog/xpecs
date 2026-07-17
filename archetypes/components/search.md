---
id: search
title: Search
layer: component
version: 1.0.0
status: stable
summary: An input-led pattern for querying content, with suggestions, clearing, and results.
since: 0.4.0
updated: 2026-07-17
tags: [search, input, query, navigation, filter]
aliases: [search-box, search-bar, search-field]
composedOf: [input, icon, icon-button, button, list, empty-state]
usedBy: [navbar, data-table, dashboard]
related: [combobox, command, input]
maintainers: [brnrdog]
---

# Search

## Intent

Search lets a person find content by typing a query. Beyond the field itself, the
pattern covers the affordances that make searching productive: a clear entry point,
a way to clear the query, live suggestions or recent searches, and a predictable
results and empty state. It's how users cut through volume to the one thing they
want.

## API

```json
{
  "props": [
    {"name":"value","type":"string","default":"","description":"Query text."},
    {"name":"placeholder","type":"string","default":"Search","description":"Empty hint."}
  ],
  "slots": [
    {"name":"input","required":true},
    {"name":"suggestions","required":false},
    {"name":"clear","required":false}
  ],
  "events": ["onSearch","onInput"],
  "a11y": {"role":"searchbox","keyboard":["Enter","Escape","ArrowDown"],"announces":["results count"]},
  "states": ["default","focus-visible","loading","empty"],
  "tokens": ["color.neutral.*","radius.md"]
}
```

## When to use / When not to use

**Use when**
- Users need to find items in a large or unbounded set by keyword.

**Avoid when**
- Choosing from a small, known set — a **select** or filters fit better.
- Selecting a single value into a field — use a **combobox**.
- Running commands/navigation — use a **command** palette.

## Anatomy

- **Field** (required) — the query input, usually with a leading search icon.
- **Clear affordance** (optional) — an icon-button to reset the query.
- **Submit** (conditional) — for submit-on-enter vs. live search.
- **Suggestions** (optional) — recent/typeahead results as you type.
- **Results & states** (required in results contexts) — results list plus loading,
  empty ("no results"), and error states.
- **Scope/filters** (optional) — restrict what is searched.

## States & behavior

- **Empty / typing** — placeholder guidance; may show recent searches on focus.
- **Live vs. on-submit** — results update as you type, or on enter.
- **Loading** — while fetching, especially for remote search.
- **No results** — an explicit empty state offering to adjust or clear.
- **Cleared** — the clear control resets query and results.

## Variants

- **Inline field** — a simple search box.
- **With suggestions** — typeahead/recent dropdown.
- **Scoped** — a filter/scope selector attached.
- **Full search experience** — field plus results and facets.

## Layout & responsiveness

The field is prominent where search is primary (navbar, top of a list). Suggestions
open in a popover beneath it; results render below or on a dedicated view. On small
screens the field may expand to full width or open from an icon.

## Accessibility

- **Semantics** — a labeled search field within a search landmark where
  appropriate; suggestions follow combobox semantics.
- **Keyboard** — type to query, arrow through suggestions, enter to submit, escape
  to clear/close; the clear control is reachable.
- **Screen reader** — result counts and loading/empty states are announced via
  live regions.
- **Clear control** — has an accessible name.

## Content guidelines

- Placeholder states what's searched ("Search invoices…"), not "Search".
- Write a helpful "no results" state with a way forward.

## Composition

**Composed of:** input, icon, icon-button (clear), button (submit), list (results),
empty-state.

**Used by:** navbar, data-table, dashboard.

## Do / Don't

**Do**
- Provide clear, loading, and empty states.
- Announce result counts to assistive tech.

**Don't**
- Hide whether search is live or requires submitting.
- Leave a "no results" dead end without a next step.

## References

- Nielsen Norman Group — search usability; WAI-ARIA combobox guidance.
