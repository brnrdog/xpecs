---
id: onboarding
title: Onboarding
layer: flow
version: 1.0.0
status: stable
summary: A guided sequence that gets a new user from first login to first meaningful value.
since: 0.4.0
updated: 2026-07-17
tags: [activation, flow, first-run, journey]
aliases: [onboarding-flow, getting-started, setup-wizard]
composedOf: [progress, form, field, button, empty-state, card, dialog, checkbox]
usedBy: []
related: [authentication, checkout]
maintainers: [brnrdog]
---

# Onboarding

## Intent

Onboarding carries a brand-new user from their first login to the moment the
product delivers value ("aha"). It gathers just enough setup to personalize the
experience, teaches the few things needed to start, and removes the blank-slate
paralysis of an empty account — all while letting motivated users skip ahead. Its
success metric is activation, not completion for its own sake.

## When to use / When not to use

**Use when**
- New users need setup, orientation, or their first data to get value.

**Avoid when**
- The product is immediately useful with no setup — don't manufacture steps.
- The "onboarding" is really a marketing tour that delays real use.

## Anatomy (steps)

- **Welcome** (optional) — sets expectations and the payoff.
- **Setup steps** (required) — the minimum configuration/personalization, one idea
  per step, with clear progress.
- **First action** (required) — create/import the first item so the account isn't
  empty (an empty state that guides).
- **Guidance** (optional) — inline hints, checklists, or a short tour.
- **Completion** (required) — confirm readiness and hand off to the product.
- **Skip / resume** (required) — let users skip and pick up later.

## States & behavior

- **Progress** — steps show position and how many remain.
- **Skippable / resumable** — users can defer steps and return; progress persists.
- **Validation** — required setup is validated before advancing.
- **Empty → filled** — the first-run empty state converts into real content.
- **Completion tracking** — a checklist may persist post-flow until done.

## Variants

- **Wizard** — sequential, full-screen steps with progress.
- **Checklist** — a persistent list of setup tasks completed at the user's pace.
- **Inline coach marks** — contextual hints layered on the real product.

## Layout & responsiveness

Wizard steps are focused single screens with visible progress and one primary
action; checklists live beside or within the product. Everything remains usable on
small screens, and steps never trap the user without a way forward or out.

## Accessibility

- **Progress** — the step position is exposed and announced as it changes.
- **Per-step forms** — follow the form/field accessibility contract.
- **Focus** — moves sensibly between steps; dialogs trap and restore focus.
- **Skippable** — skip/resume controls are reachable and clearly labeled.

## Content guidelines

- One idea per step; ask only for setup that improves the first experience.
- Make the payoff and remaining steps clear; always offer a skip.

## Composition

**Composed of:** progress, form, field, button, empty-state, card, dialog,
checkbox (checklist).

**Used by:** Not applicable — a top-level journey following first sign-in.

## Do / Don't

**Do**
- Get users to first value fast; let them skip and resume.
- Replace the empty slate with a guided first action.

**Don't**
- Gate the product behind long, skippable-feeling setup.
- Confuse a feature tour with genuine activation.

## References

- Nielsen Norman Group — onboarding and first-time user experience.
