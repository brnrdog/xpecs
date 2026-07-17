---
id: stat
title: Stat
layer: component
version: 1.0.0
status: stable
summary: A compact display of a single key metric with its label and optional trend.
since: 0.4.0
updated: 2026-07-17
tags: [data, metric, kpi, dashboard]
aliases: [kpi, metric, stat-card, metric-card]
usedBy: [dashboard]
related: [card, chart]
maintainers: [brnrdog]
---

# Stat

## Intent

A stat surfaces one number that matters — revenue, active users, conversion rate —
with just enough context to interpret it: a label, and often a change indicator or
a tiny trend. It turns a single figure into a glanceable signal, the building block
that tiles into a dashboard's metric row.

## API

```json
{
  "props": [
    {"name":"trend","type":"enum","values":["up","down","flat"],"default":"flat","description":"Direction of change."}
  ],
  "slots": [
    {"name":"label","required":true},
    {"name":"value","required":true},
    {"name":"delta","required":false}
  ],
  "a11y": {"announces":["label and value"]},
  "states": ["default"],
  "tokens": ["color.status.*"]
}
```

## When to use / When not to use

**Use when**
- Highlighting a single headline metric with light context.
- Building a row/grid of KPIs on a dashboard or summary.

**Avoid when**
- Many values must be compared in detail — use a **table** or **chart**.
- The number needs heavy explanation to be meaningful.

## Anatomy

- **Value** (required) — the metric, formatted with units.
- **Label** (required) — what the number measures.
- **Change indicator** (optional) — delta vs. a prior period, with direction.
- **Trend** (optional) — a sparkline or tiny chart.
- **Icon** (optional) — reinforces the metric's meaning.

## States & behavior

- **Loading** — a skeleton in the value's shape.
- **Populated** — value with optional delta/trend.
- **Positive / negative change** — direction conveyed by more than color (arrow,
  sign).
- **Interactive** (optional) — the whole tile links to detail.

## Variants

- **Value only** — number and label.
- **With change** — delta vs. previous period.
- **With sparkline** — a compact trend.

## Layout & responsiveness

A stat is compact: label and prominent value stacked, with the change/trend nearby.
Tiles align to a consistent height and tile into a responsive row that reflows to
fewer columns on small screens.

## Accessibility

- **Structure** — the value and its label are associated so the number is
  meaningful to assistive tech.
- **Change** — direction conveyed by icon/sign and text, not color alone.
- **Trend** — sparklines provide a text summary or accessible value.
- **Interactive** — linked tiles expose a clear accessible name.

## Content guidelines

- Format the value with units and sensible precision.
- State the comparison period for any change ("vs. last month").

## Composition

```json
{
  "parts": [
    {"ref":"typography","slot":"value"},
    {"ref":"badge","slot":"delta"},
    {"ref":"icon","slot":"label"},
    {"ref":"chart","slot":"value","note":"sparkline"}
  ]
}
```

## Do / Don't

**Do**
- Give every number a clear label and comparison context.
- Convey change direction with more than color.

**Don't**
- Crowd a tile with multiple competing numbers.
- Show a delta without saying against what.

## References

- Nielsen Norman Group — dashboards and KPI presentation.
