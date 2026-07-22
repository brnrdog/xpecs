---
id: stat-grid
title: Stat Grid
layer: block
version: 1.0.0
status: stable
summary: A responsive band of key-metric tiles that gives a view its at-a-glance summary.
since: 0.8.0
updated: 2026-07-22
tags: [application, dashboard, data, metrics, kpi, section]
aliases: [kpi-row, metric-summary, stats-band, stats-row]
usedBy: [dashboard]
related: [stat, card, chart, page-header]
maintainers: [brnrdog]
implementation: StatGrid.res
---

# Stat Grid

## Intent

A stat grid is the summary row a dashboard opens with: a small set of key
metrics, tiled side by side, that answers "how are we doing?" before the user
reads anything else. Each tile is a **stat** (value, label, change); the grid's
job is the arrangement — consistent tile sizing, a sensible reflow, and shared
loading/empty behavior — so the metrics read as one glanceable band rather than
scattered numbers.

## API

```json
{
  "responsive": {
    "container": true,
    "reflow": [
      {
        "at": "lg",
        "pattern": "reflow-columns",
        "note": "four tiles step down to two columns, then one"
      }
    ]
  },
  "props": [],
  "slots": [
    {"name":"heading","required":false},
    {"name":"stats","required":true}
  ],
  "a11y": {"announces":["each stat's label and value"]},
  "states": ["default", "loading", "empty"],
  "tokens": ["color.neutral.*", "color.status.*"]
}
```

## When to use / When not to use

**Use when**
- Opening a dashboard or overview with a handful of headline metrics.
- Several related KPIs deserve equal, side-by-side prominence.

**Avoid when**
- There is a single metric — one **stat** inline serves better.
- Metrics need detailed comparison across many dimensions — use a **table** or
  **chart**.

## Anatomy

- **Heading** (optional) — names the band or its period ("This month").
- **Stat tiles** (required) — two to six stats, each with value, label, and
  optional change/trend.
- **Tile surfaces** (optional) — tiles may sit on cards or share one surface
  divided by separators.

## States & behavior

- **Loading** — every tile shows a skeleton in the value's shape; the grid
  reserves its layout so nothing shifts on arrival.
- **Default** — populated tiles; changes carry direction and comparison period.
- **Empty / first-run** — tiles show a placeholder value ("—") or the band
  yields to an onboarding empty state.
- **Filtered** — a scope or date-range change updates all tiles together.
- **Interactive** (optional) — a tile links to the metric's detail view.

## Variants

- **Plain band** — stats on the page surface, divided by separators.
- **Card tiles** — each stat on its own card surface.
- **Linked tiles** — each tile navigates to its detail.

## Layout & responsiveness

Tiles share one equal-width, equal-height grid — typically three or four across —
and step down to two columns, then one, as the container narrows. Order carries
priority: the most important metric sits first, so it stays on top after reflow.

## Accessibility

- **Structure** — the band is a list of stats; each tile associates its value
  with its label per the stat contract.
- **Reading order** — tiles are encountered in priority order, matching the
  visual order at every width.
- **Change** — deltas convey direction with icon/sign and text, never color
  alone.
- **Loading** — skeletons are hidden from assistive tech; the band exposes a
  loading state accessibly.

## Content guidelines

- Pick a handful of metrics that answer the page's question — not every number
  you have.
- Keep labels parallel in form ("Revenue", "Orders", "Refunds") and state the
  comparison period once if shared.

## Composition

```json
{
  "parts": [
    {"ref":"typography","slot":"heading"},
    {"ref":"stat","slot":"stats"},
    {"ref":"card","slot":"stats","note":"card-tile variant"},
    {"ref":"skeleton","slot":"stats","note":"loading state"},
    {"ref":"separator","slot":"stats","note":"plain-band variant"}
  ]
}
```

## Do / Don't

**Do**
- Keep tiles to a consistent shape and a single number each.
- Reserve layout during loading so values don't jump.

**Don't**
- Tile more than about six metrics — beyond that it's a table.
- Mix tile sizes to make one metric shout; use order for priority.

## References

- Nielsen Norman Group — dashboard design and KPI presentation.
