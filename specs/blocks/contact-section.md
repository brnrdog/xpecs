---
id: contact-section
title: Contact Section
layer: block
version: 1.0.0
status: stable
summary: A section pairing a short message form with direct contact details so visitors can reach you.
since: 0.8.0
updated: 2026-07-22
tags: [marketing, landing, section, conversion, lead-gen, support]
aliases: [contact, contact-form, get-in-touch, contact-us]
usedBy: [landing-page]
related: [form, cta-section, faq, footer, newsletter]
maintainers: [brnrdog]
implementation: ContactSection.res
---

# Contact Section

## Intent

A contact section turns "I have a question" into a message you actually receive.
It pairs the two things a visitor needs at that moment: a short form for
writing now, and direct channels (email, phone, address, hours) for people who
prefer their own client or need a human. It is the lead-gen and support
entry point of a marketing page — so it minimizes fields, sets response
expectations, and confirms clearly that the message went through.

## API

```json
{
  "responsive": {
    "container": true,
    "minTarget": "44px",
    "reflow": [
      {
        "at": "md",
        "pattern": "stack",
        "note": "the form and the details column stack; the form leads"
      }
    ]
  },
  "props": [],
  "slots": [
    {"name":"heading","required":true},
    {"name":"description","required":false},
    {"name":"form","required":true},
    {"name":"details","required":false}
  ],
  "a11y": {"announces":["submission success", "validation errors"]},
  "states": ["default", "submitting", "success", "error"],
  "tokens": ["color.neutral.*", "color.action.*", "color.status.*"]
}
```

## When to use / When not to use

**Use when**
- A marketing page needs a way to capture questions, leads, or sales inquiries.
- Direct channels (email, phone, address) should be findable alongside the
  form.

**Avoid when**
- You only want email addresses for updates — that's a **newsletter** block.
- The need is in-product support — use a help surface, not a marketing section.

## Anatomy

- **Heading** (required) — invites contact and says who answers.
- **Description** (optional) — response expectations ("we reply within a day").
- **Form** (required) — the minimum viable fields: name, email, message; a
  topic select only when routing truly needs it.
- **Contact details** (optional) — email, phone, address, hours — each a usable
  link (mailto, tel, map).
- **Confirmation** (required behavior) — the success state shown after submit.

## States & behavior

- **Default** — form ready; required fields marked.
- **Submitting** — the submit button shows progress and duplicate submissions
  are prevented; inputs stay populated.
- **Success** — a clear confirmation replaces or tops the form, restating what
  happens next.
- **Error** — validation errors appear inline beside their fields; a submission
  failure preserves everything typed and offers retry.

## Variants

- **Split** — form beside contact details; the common default.
- **Form only** — a centered form when there are no direct channels.
- **Details-led** — channels prominent with a minimal form, for
  location-centric businesses.

## Layout & responsiveness

Two columns — the form takes the wider share, details the narrower — aligned to
a shared top edge. As the container narrows the columns stack with the form
first, since writing now is the primary intent. Fields span the form's full
width; touch targets hold the minimum size.

## Accessibility

- **Form contract** — fields, labels, validation, and submission follow the
  form spec: every control labeled, errors associated with their fields.
- **Announcements** — success and error outcomes are announced (status/alert),
  not just shown; focus moves to the outcome message.
- **Details** — email, phone, and address are real links with descriptive
  accessible names, not bare icons.
- **Keyboard** — the whole section completes with keyboard alone; `Enter`
  submits from any field.

## Content guidelines

- Ask only what you need to reply — every extra field costs submissions.
- State response time honestly and confirm with next steps, not just "thanks".
- Write the heading as an invitation ("Talk to us"), not a label ("Form").

## Composition

```json
{
  "parts": [
    {"ref":"typography","slot":"heading"},
    {"ref":"form","slot":"form"},
    {"ref":"field","slot":"form"},
    {"ref":"input","slot":"form"},
    {"ref":"textarea","slot":"form"},
    {"ref":"button","slot":"form","props":{"variant":"primary","type":"submit"}},
    {"ref":"link","slot":"details","note":"mailto / tel links"},
    {"ref":"icon","slot":"details"}
  ]
}
```

## Do / Don't

**Do**
- Keep the form to three or four fields.
- Offer direct channels for people who won't use forms.

**Don't**
- Gate contact behind account creation or captchas hostile to assistive tech.
- Swallow the message into a void — always confirm and set expectations.

## References

- Nielsen Norman Group — contact-us pages and form usability.
- WCAG — forms, labels, and status messages (3.3.x, 4.1.3).
