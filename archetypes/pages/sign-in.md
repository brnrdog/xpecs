---
id: sign-in
title: Sign In
layer: page
version: 1.0.0
status: stable
summary: A focused page that authenticates a returning user with minimal friction.
since: 0.3.0
updated: 2026-07-17
tags: [auth, authentication, form, account, security]
aliases: [login, log-in, signin]
composedOf: [form, field, input, input-otp, checkbox, button, link, alert, separator]
usedBy: []
related: [form, settings]
maintainers: [brnrdog]
---

# Sign In

## Intent

A sign-in page authenticates a returning user and gets them into the product with
as little friction as possible. It is a focused, single-purpose screen: collect
credentials (or start a passwordless/again-party flow), handle errors clearly, and
provide the escape hatches — reset password, alternate methods, and the path to
sign up.

## When to use / When not to use

**Use when**
- A returning user must authenticate to access the product.

**Avoid when**
- Creating a new account — use a sign-up page (related, distinct goals).
- A lightweight step-up re-auth suffices — a dialog may be enough.

## Anatomy

- **Identity / branding** (optional) — logo and product name for trust.
- **Credential form** (required) — email/username and password, or a passwordless
  entry.
- **Alternate methods** (optional) — social/SSO providers, magic link, or a
  one-time code (input-otp).
- **Options** (optional) — "remember me", show-password toggle.
- **Recovery** (required) — forgot-password link.
- **Cross-links** (required) — path to sign up.
- **Feedback** (required) — inline validation and a clear authentication-error
  message.

## States & behavior

- **Editing** — validate format on blur/submit; preserve input on error.
- **Submitting** — the submit shows progress; prevent duplicate attempts.
- **Auth error** — a clear, non-leaky message ("email or password is incorrect");
  focus is directed to it.
- **Multi-step** — passwordless or 2FA advances to a code step (input-otp).
- **Locked / rate-limited** — communicates the cause and next step.

## Variants

- **Password** — email + password.
- **Passwordless** — magic link or one-time code.
- **SSO-first** — provider buttons with an email fallback.
- **Two-step** — credentials then a verification code.

## Layout & responsiveness

A narrow, centered card is the conventional layout, optionally beside a brand
panel on wide screens that collapses on small ones. Keep the form short, the
primary action prominent, and recovery/sign-up links visible.

## Accessibility

- **Semantics** — a form with associated labels; the error summary is announced
  and focus moves to it on failure.
- **Keyboard** — full keyboard operation; `Enter` submits; show-password and
  provider buttons are reachable.
- **Autofill & code entry** — supports credential autofill and OS one-time-code
  autofill for the code step.
- **Security messaging** — errors avoid revealing which field was wrong beyond
  what's necessary, while remaining actionable.

## Content guidelines

- Keep the form minimal; ask only for what's needed to authenticate.
- Write a single, clear error for failed authentication.
- Make "forgot password" and "create account" easy to find.

## Composition

**Composed of:** form, field, input, input-otp, checkbox, button, link, alert,
separator.

**Used by:** Not applicable — a top-level experience.

## Do / Don't

**Do**
- Preserve entered values on error and focus the message.
- Offer recovery and sign-up paths.

**Don't**
- Reveal whether an account exists through differential error messages.
- Clear the form on a failed attempt.

## References

- WCAG — Error Identification; Labels or Instructions.
- OWASP — authentication UX and messaging guidance.
