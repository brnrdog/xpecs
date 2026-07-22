---
id: settings
title: Settings
layer: page
version: 1.1.0
status: stable
summary: A page for viewing and changing a user's or system's configuration, organized into sections.
since: 0.3.0
updated: 2026-07-22
tags: [configuration, preferences, forms, account]
aliases: [preferences, account-settings, options]
usedBy: []
related: [dashboard, form]
maintainers: [brnrdog]
---

# Settings

## Intent

A settings page lets users view and adjust configuration — account, profile,
notifications, billing, security — organized so a specific option is easy to find
and safe to change. It groups many controls into coherent sections and makes the
state of each setting, and how changes are saved, unmistakable.

## When to use / When not to use

**Use when**
- Users need to manage a non-trivial set of preferences or account options.
- Options divide into meaningful categories worth navigating between.

**Avoid when**
- There is a single toggle or option — present it inline where it applies.

## Anatomy

- **Section navigation** (required for larger sets) — a sidebar, tabs, or menu of
  categories.
- **Section content** (required) — grouped settings, each a field or control with
  a label and description.
- **Controls** (required) — inputs, switches, selects, radio-groups, and buttons.
- **Save model** (required) — either instant-apply per control or an explicit
  save/cancel per section.
- **Feedback** (required) — success, error, and unsaved-changes indication.
- **Dangerous actions** (optional) — a clearly separated destructive zone.

## States & behavior

- **Instant-apply** — switches/toggles take effect immediately with confirmation.
- **Form-style** — grouped fields saved on submit, with dirty-state tracking and a
  warning before discarding unsaved changes.
- **Validation** — invalid values are flagged inline and block save.
- **Saving / saved / error** — clearly communicated.

## Variants

- **Sidebar sections** — a left nav of categories with content on the right.
- **Tabbed** — categories as tabs for a smaller set.
- **Single scroll** — sections stacked with anchor navigation.

## Layout & responsiveness

Category navigation alongside a single readable content column; on small screens
the navigation collapses (into a menu or top tabs) and content goes full-width.
Keep a consistent field rhythm and clear section headings.

## Accessibility

- **Structure** — section headings and landmarks make categories navigable.
- **Controls** — every setting has an associated label and description; validation
  and required states are exposed.
- **Save feedback** — saving/success/error conveyed via live regions, not color
  alone.
- **Keyboard** — navigation between sections and operation of every control is
  fully keyboard-accessible.

## Content guidelines

- Group related settings; give each a clear label and a plain-language description.
- Make the save model obvious (instant vs. explicit save).
- Separate and confirm destructive actions.

## Composition

```json
{
  "parts": [
    {"ref":"sidebar","slot":"chrome"},
    {"ref":"page-header","slot":"content","note":"section title and context"},
    {"ref":"tabs","slot":"content"},
    {"ref":"navigation-menu","slot":"chrome"},
    {"ref":"form","slot":"content"},
    {"ref":"field","slot":"content"},
    {"ref":"input","slot":"content"},
    {"ref":"switch","slot":"content"},
    {"ref":"select","slot":"content"},
    {"ref":"radio-group","slot":"content"},
    {"ref":"button","slot":"content"},
    {"ref":"separator","slot":"content"},
    {"ref":"alert","slot":"content"}
  ]
}
```

## Do / Don't

**Do**
- Make each setting's meaning and current value clear.
- Communicate exactly how and when changes are saved.

**Don't**
- Mix instant-apply and save-required controls without making it obvious.
- Place destructive actions where they're easy to trigger by accident.

## References

- Nielsen Norman Group — preferences and settings guidance.
