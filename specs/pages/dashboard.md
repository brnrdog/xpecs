---
id: dashboard
title: Dashboard
layer: page
version: 1.0.0
status: stable
summary: An at-a-glance overview page that surfaces key metrics, status, and entry points to act.
since: 0.3.0
updated: 2026-07-17
tags: [analytics, overview, application, data]
aliases: [home, overview, console]
usedBy: []
related: [settings, data-table, chart]
maintainers: [brnrdog]
---

# Dashboard

## Intent

A dashboard gives users an at-a-glance understanding of the state of a system and
fast paths to act on it. It answers "how are things, and what needs my attention?"
by arranging the most important metrics, trends, and recent activity into a
scannable overview, with drill-downs to the detail behind each summary.

## When to use / When not to use

**Use when**
- Users return regularly to monitor status and jump into work.
- Several related metrics and activity streams benefit from a single overview.

**Avoid when**
- The user has one primary task — a focused task page serves better.
- There isn't enough meaningful data to justify an overview (show an onboarding
  empty state instead).

## Anatomy

- **App shell** (required) — navbar and/or sidebar for global navigation, plus
  breadcrumbs or a page title for context.
- **Toolbar / filters** (optional) — date range, scope, and view controls.
- **Metric summary** (required) — a row of stat/KPI cards.
- **Visualizations** (optional) — charts for trends and comparisons.
- **Detail regions** (optional) — data-tables and lists of recent activity.
- **States** (required) — loading (skeletons), empty (first-run), and error.

## States & behavior

- **Loading** — regions show skeletons; the layout is reserved to avoid shift.
- **Populated** — metrics, charts, and tables render with live data.
- **Empty / first-run** — an onboarding empty state guides setup.
- **Filtered** — global controls (time range, scope) update all regions.
- **Error** — a region that fails shows a contained, retryable error.

## Variants

- **Analytics dashboard** — metric- and chart-heavy.
- **Operational dashboard** — status, queues, and recent activity.
- **Personal home** — tailored shortcuts and summaries.

## Layout & responsiveness

A responsive grid of regions inside the app shell: a metric row up top, charts and
tables below, reflowing from multiple columns to a single column on small screens.
Prioritize the most important summary above the fold; let detail regions scroll.

## Accessibility

- **Structure** — a logical heading outline and landmarks (nav, main) so regions
  are navigable.
- **Data alternatives** — charts provide accessible data/summaries; tables use
  proper semantics.
- **Keyboard** — filters, drill-downs, and region controls are fully operable.
- **Live updates** — auto-refreshing regions announce changes politely without
  stealing focus.
- **States** — loading/empty/error are conveyed as text, not visuals alone.

## Content guidelines

- Lead with the metrics that drive decisions; label units and time ranges.
- Make each summary drill down to its detail.
- Write empty states that help the user get to first value.

## Composition

```json
{
  "parts": [
    {"ref":"navbar","slot":"chrome"},
    {"ref":"sidebar","slot":"chrome"},
    {"ref":"breadcrumb","slot":"chrome"},
    {"ref":"toolbar","slot":"content"},
    {"ref":"card","slot":"content"},
    {"ref":"stat","slot":"content"},
    {"ref":"chart","slot":"content"},
    {"ref":"data-table","slot":"content"},
    {"ref":"list","slot":"content"},
    {"ref":"empty-state","slot":"content","note":"no data"}
  ]
}
```

## Do / Don't

**Do**
- Surface what needs attention first and link to the detail.
- Keep every region's loading, empty, and error states honest.

**Don't**
- Crowd the page with vanity metrics that don't inform action.
- Block the whole page on one slow region.

## References

- Nielsen Norman Group — dashboard design and information hierarchy.
