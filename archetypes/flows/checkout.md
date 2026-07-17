---
id: checkout
title: Checkout
layer: flow
version: 1.0.0
status: stable
summary: A step-by-step flow that collects the details needed to complete a purchase.
since: 0.4.0
updated: 2026-07-17
tags: [commerce, payment, flow, conversion, journey]
aliases: [checkout-flow, purchase-flow, payment-flow]
composedOf: [form, field, input, radio-group, list, card, button, alert, progress]
usedBy: []
related: [pricing, onboarding]
maintainers: [brnrdog]
---

# Checkout

## Intent

Checkout is the journey from "I want this" to a completed purchase. It collects the
necessary details — contact, shipping, and payment — confirms the order, and
processes it, all while protecting a fragile moment: every unnecessary field,
surprise cost, or unclear error is a chance to abandon. Its job is to reduce
friction and build confidence right up to "place order."

## When to use / When not to use

**Use when**
- Completing a purchase that requires payment and (often) shipping details.

**Avoid when**
- A single tap completes the buy (stored payment, one-click) — collapse the flow.
- No payment is involved — it's a form or onboarding, not checkout.

## Anatomy (steps)

- **Order summary** (required) — items, quantities, and a transparent cost
  breakdown (subtotal, shipping, tax, total), present throughout.
- **Contact / account** (required) — email; guest checkout offered.
- **Shipping** (conditional) — address and method selection.
- **Payment** (required) — payment details, with security cues.
- **Review** (required) — confirm everything before charging.
- **Confirmation** (required) — success with an order reference and next steps.
- **Progress** (required for multi-step) — where the user is in the flow.

## States & behavior

- **Step progression** — one section at a time (or a single scroll) with a
  persistent order summary.
- **Validation** — address/payment validated inline before advancing.
- **Cost transparency** — totals update as shipping/discounts change; no surprise
  fees at the end.
- **Processing** — a clear in-progress state; prevent double-submission.
- **Payment error** — clear, recoverable messaging without losing entered data.
- **Confirmation** — order reference, receipt, and what happens next.

## Variants

- **Multi-step** — contact → shipping → payment → review.
- **Single-page** — all sections on one scroll with a sticky summary.
- **Express** — wallet/one-click that skips most steps.
- **Guest vs. account** — purchase without or with sign-in.

## Layout & responsiveness

A focused layout (often minimal chrome to reduce distraction) with the form leading
and the order summary persistent (beside on wide screens, collapsible on small).
Progress is visible in multi-step variants; the primary action is unmistakable.

## Accessibility

- **Per-step forms** — labels, validation, and error summaries follow the
  form/field contract; focus moves to errors.
- **Progress** — the current step is exposed and announced.
- **Processing** — busy/success states are announced without stealing focus.
- **Cost changes** — total updates are perceivable to assistive tech.
- **Payment fields** — support autofill and clear, secure labeling.

## Content guidelines

- Show the full cost breakdown early and keep it visible; no surprise fees.
- Offer guest checkout; ask only for what's required.
- Write payment errors as specific, recoverable next steps.

## Composition

**Composed of:** form, field, input, radio-group, list (order items), card, button,
alert, progress.

**Used by:** Not applicable — a top-level journey; follows plan/cart selection.

## Do / Don't

**Do**
- Keep costs transparent and the order summary visible.
- Preserve entered data through validation and payment errors.

**Don't**
- Introduce surprise costs at the last step.
- Force account creation to complete a purchase.

## References

- Baymard Institute — checkout usability and cart abandonment research.
