---
id: newsletter
title: Newsletter
layer: block
version: 1.0.0
status: stable
summary: A focused email-capture band that converts interest into a subscription with a single field.
since: 0.8.0
updated: 2026-07-22
tags: [marketing, landing, section, conversion, email, lead-gen]
aliases: [email-signup, subscribe, newsletter-signup, email-capture]
usedBy: [landing-page]
related: [cta-section, contact-section, footer]
maintainers: [brnrdog]
implementation: Newsletter.res
---

# Newsletter

## Intent

A newsletter block captures the visitors who aren't ready to buy but don't want
to lose the thread: one email field, one button, one promise about what they'll
get. It is the lowest-commitment conversion on the page, so friction is the
enemy — a single visible field, an honest value proposition ("what and how
often"), and an immediate, unmistakable confirmation. Where a **cta-section**
pushes the primary action, a newsletter offers the fallback relationship.

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
        "note": "the inline field-and-button pair stacks; the button goes full-width"
      }
    ]
  },
  "props": [],
  "slots": [
    {"name":"heading","required":true},
    {"name":"description","required":false},
    {"name":"form","required":true},
    {"name":"consent","required":false}
  ],
  "a11y": {"announces":["subscription success", "validation error"]},
  "states": ["default", "submitting", "success", "error"],
  "tokens": ["color.neutral.*", "color.action.*", "color.status.*"]
}
```

## When to use / When not to use

**Use when**
- Offering ongoing content (updates, digest, changelog) as a low-commitment
  conversion, mid-page or near the footer.

**Avoid when**
- You need more than an email address — that's a **contact-section** or a
  proper sign-up form.
- You have nothing recurring to send — collecting addresses without a promise
  erodes trust.

## Anatomy

- **Heading** (required) — the offer in a few words ("Get the monthly digest").
- **Description** (optional) — what subscribers get and how often.
- **Form** (required) — one email field with its button, acting as a single
  composite control.
- **Consent note** (optional) — privacy reassurance or required consent
  checkbox, kept to one quiet line.
- **Confirmation** (required behavior) — the success message shown in place.

## States & behavior

- **Default** — field ready, placeholder shows an example address.
- **Submitting** — the button shows progress; duplicate submits are prevented.
- **Success** — the form is replaced (or topped) by a confirmation naming the
  next step ("check your inbox to confirm").
- **Error** — an invalid address is flagged inline without clearing the field;
  a failed submission offers retry.

## Variants

- **Inline band** — field and button side by side in a slim, full-width strip.
- **Card** — the block on its own surface, mid-content or in a footer column.
- **With consent** — a required checkbox where regulation demands explicit
  opt-in.

## Layout & responsiveness

Heading and description center (or lead) above the form row; the email field
takes the flexible width with the button attached at its end as one composite
control. On narrow containers the pair stacks and the button spans full width.
The consent line sits directly under the form at reduced emphasis.

## Accessibility

- **Label** — the email field has a real label (visible or accessible);
  placeholder text is not the label.
- **Keyboard** — `Enter` in the field submits; the whole block works with
  keyboard alone.
- **Announcements** — success and error are announced via a status/alert
  region, and focus moves to the outcome message.
- **Consent** — any required checkbox is a true labeled control, unchecked by
  default.

## Content guidelines

- Say exactly what and how often ("One email a month. No spam.").
- Confirm with the next action, not just "subscribed".
- Never pre-check consent or hide unsubscribe terms.

## Composition

```json
{
  "parts": [
    {"ref":"typography","slot":"heading"},
    {"ref":"input-group","slot":"form","note":"field + attached button"},
    {"ref":"input","slot":"form","props":{"type":"email"}},
    {"ref":"button","slot":"form","props":{"variant":"primary","type":"submit"}},
    {"ref":"checkbox","slot":"consent","note":"explicit opt-in variant"},
    {"ref":"alert","slot":"form","note":"success / error outcome"}
  ]
}
```

## Do / Don't

**Do**
- Keep it to one field — every additional field halves the signups.
- Make the confirmation instant and specific.

**Don't**
- Promise "updates" vaguely and deliver daily promotions.
- Rely on color alone to show the error state.

## References

- Nielsen Norman Group — newsletter signup and email UX research.
- WCAG — status messages (4.1.3) and form labeling.
