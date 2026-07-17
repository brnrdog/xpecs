---
id: pricing
title: Pricing Page
layer: page
version: 1.0.0
status: stable
summary: A page that presents plans and their value to help a visitor choose and convert.
since: 0.3.0
updated: 2026-07-17
tags: [marketing, conversion, plans, pricing]
aliases: [plans, pricing-plans]
usedBy: []
related: [landing-page, card]
maintainers: [brnrdog]
---

# Pricing Page

## Intent

A pricing page helps a visitor compare plans and choose the right one, then act.
It has to make value and differences legible at a glance, reduce the anxiety of
committing, and guide most people toward the intended plan — all while answering
the practical questions (billing period, limits, what's included) that block a
decision.

## When to use / When not to use

**Use when**
- Presenting paid plans/tiers a visitor selects between to sign up or buy.

**Avoid when**
- There is a single plan or price — state it plainly without a comparison page.

## Anatomy

- **Header** (required) — a concise value statement and, often, a billing-period
  toggle (monthly/annual).
- **Plan cards** (required) — name, price, a short pitch, key features, and a call
  to action; a recommended plan is highlighted.
- **Highlight** (optional) — a "most popular"/recommended badge on one plan.
- **Comparison table** (optional) — a detailed feature-by-plan matrix.
- **FAQ** (optional) — removes last-mile objections.
- **Footer** (required) — trust signals, contact, and legal.

## States & behavior

- **Billing toggle** — switching monthly/annual updates all prices (and shows
  savings).
- **Recommended plan** — visually emphasized to guide choice.
- **Currency/locale** (optional) — prices adapt to region.
- **CTA per plan** — each plan's action reflects its state (start, upgrade,
  contact sales).

## Variants

- **Tiered cards** — two to four plans side by side.
- **Cards + comparison table** — summary cards over a detailed matrix.
- **Usage-based** — a calculator/estimate for metered pricing.

## Layout & responsiveness

Plan cards sit in a row on wide screens, emphasizing the recommended plan, and
stack into a single column on small screens (keeping the recommended plan
prominent). A comparison table scrolls horizontally or restructures on narrow
widths.

## Accessibility

- **Structure** — clear headings; the billing toggle's effect on prices is
  announced.
- **Comparison table** — real table semantics with header associations.
- **Keyboard** — the billing toggle, plan CTAs, and FAQ are fully operable.
- **Non-color emphasis** — the recommended plan is marked by more than color.

## Content guidelines

- Lead with value, not just numbers; make what's included scannable.
- Show billing period and any savings clearly; avoid hidden costs.
- Use one specific CTA verb per plan.

## Composition

```json
{
  "parts": [
    {"ref":"navbar","slot":"chrome"},
    {"ref":"card","slot":"content"},
    {"ref":"badge","slot":"content"},
    {"ref":"switch","slot":"content","note":"billing toggle"},
    {"ref":"toggle-group","slot":"content","note":"billing toggle"},
    {"ref":"button","slot":"content"},
    {"ref":"table","slot":"content"},
    {"ref":"accordion","slot":"content"},
    {"ref":"faq","slot":"content"},
    {"ref":"footer","slot":"chrome"}
  ]
}
```

## Do / Don't

**Do**
- Make plan differences and what's included easy to compare.
- Guide toward a recommended plan without dark patterns.

**Don't**
- Hide the billing period, limits, or real costs.
- Overwhelm the first view with an exhaustive matrix before the summary.

## References

- Nielsen Norman Group — pricing page and plan-comparison usability.
