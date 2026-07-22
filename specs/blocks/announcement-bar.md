---
id: announcement-bar
title: Announcement Bar
layer: block
version: 1.0.0
status: stable
summary: A slim, page-width strip that surfaces one timely message — a launch, promotion, or notice — with an optional action and dismissal.
since: 0.8.0
updated: 2026-07-22
tags: [marketing, application, section, notification, promotion]
aliases: [banner, promo-bar, notification-bar, top-bar]
usedBy: [landing-page]
related: [alert, toast, navbar, hero]
maintainers: [brnrdog]
implementation: AnnouncementBar.res
---

# Announcement Bar

## Intent

An announcement bar carries one timely, site-wide message in the least intrusive
place that still gets seen: a slim strip above the navbar. A launch, a
promotion, a maintenance notice — one sentence, one optional action, and a way
to make it go away for good. It differs from an **alert** (contextual, inline
with content) and a **toast** (transient feedback to an action): the bar is
page-level, present on arrival, and persists until dismissed or expired.

## API

```json
{
  "responsive": {
    "container": true,
    "minTarget": "44px",
    "reflow": [
      {
        "pattern": "wrap",
        "note": "message and action wrap onto a second line; the dismiss control stays reachable"
      }
    ]
  },
  "props": [
    {"name":"variant","type":"enum","values":["neutral","accent","warning"],"default":"neutral","description":"The strip's tone: quiet notice, promotional emphasis, or a cautionary heads-up."}
  ],
  "slots": [
    {"name":"message","required":true},
    {"name":"action","required":false},
    {"name":"dismiss","required":false}
  ],
  "events": ["onDismiss"],
  "a11y": {"announces":["message when injected after load"]},
  "states": ["default", "dismissed"],
  "tokens": ["color.neutral.*", "color.accent", "color.status.warning"]
}
```

## When to use / When not to use

**Use when**
- One timely message should reach every visitor: a release, an event, a
  promotion, planned maintenance.

**Avoid when**
- The message is feedback on the user's own action — use a **toast**.
- The message concerns specific content on the page — use an inline **alert**.
- It would become permanent chrome — a bar nobody can dismiss and that never
  changes is banner blindness in the making.

## Anatomy

- **Message** (required) — one sentence, plain and specific.
- **Action** (optional) — a single link or compact button ("See what's new").
- **Dismiss** (optional but recommended) — a close control that hides the bar
  and remembers the choice.
- **Icon** (optional) — a small glyph reinforcing the message's tone.

## States & behavior

- **Default** — the strip renders above the page chrome on arrival.
- **Dismissed** — the close control hides the bar; the choice persists (per
  message, so a *new* announcement may appear later) and the layout reflows
  without jumping.
- **Expired** — time-boxed messages remove themselves after their moment
  passes.

## Variants

- **Neutral** — quiet notices; blends with the chrome.
- **Accent** — promotional emphasis for launches and offers.
- **Warning** — cautionary heads-up (maintenance, deprecation) with a status
  tone.

## Layout & responsiveness

A full-width strip, one line tall, above the navbar: message centered or
leading, action beside it, dismiss pinned to the trailing edge. On narrow
screens the message and action wrap to a second line while the dismiss control
keeps its position and minimum target size. The bar never overlaps content — it
pushes the page down, and removing it reflows cleanly.

## Accessibility

- **Semantics** — part of the page on load, read in document order before the
  navigation; a bar injected *after* load uses a status region so it is
  announced.
- **Keyboard** — the action and the dismiss control are focusable in order;
  dismissing moves focus to a sensible neighbor, not to a void.
- **Dismiss** — the close control has an accessible name ("Dismiss
  announcement"), not just an × glyph.
- **Contrast & tone** — all variants meet text contrast; the warning tone is
  conveyed by icon and wording, not color alone.

## Content guidelines

- One message, one sentence, one action — a bar that rotates three offers says
  nothing.
- Say the concrete thing ("v2 ships May 4"), not the vague thing ("Exciting
  news!").
- Retire messages on time; a stale announcement costs credibility.

## Composition

```json
{
  "parts": [
    {"ref":"icon","slot":"message"},
    {"ref":"link","slot":"action"},
    {"ref":"button","slot":"action","props":{"variant":"ghost","size":"sm"}},
    {"ref":"icon-button","slot":"dismiss","note":"the close control"}
  ]
}
```

## Do / Don't

**Do**
- Remember dismissal so the same message doesn't return on every page.
- Keep the bar to a single line of purpose.

**Don't**
- Stack multiple bars — one message at a time.
- Use it for critical errors that belong in the page's content flow.

## References

- Nielsen Norman Group — banner blindness and site-wide notifications.
- WAI-ARIA — status live regions for injected messages.
