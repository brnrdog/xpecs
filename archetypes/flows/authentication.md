---
id: authentication
title: Authentication
layer: flow
version: 1.0.0
status: stable
summary: A multi-step journey that verifies a user's identity to grant access to the product.
since: 0.4.0
updated: 2026-07-17
tags: [auth, security, flow, account, journey]
aliases: [auth-flow, login-flow, sign-in-flow]
composedOf: [sign-in, form, field, input, input-otp, button, alert, link]
usedBy: []
related: [sign-in, onboarding, checkout]
maintainers: [brnrdog]
---

# Authentication

## Intent

Authentication is the journey that establishes who the user is and lets them in.
It spans more than one screen — enter credentials, verify a second factor, recover
a forgotten password, or complete a passwordless step — and its job is to be
secure without being hostile: minimal friction for legitimate users, clear
recovery paths, and honest, non-leaky handling of failures.

## When to use / When not to use

**Use when**
- Users must prove identity to access protected functionality across one or more
  steps.

**Avoid when**
- A single screen fully covers it — that's the **sign-in** page archetype on its
  own.
- Establishing a new account is the goal — that's a sign-up flow (related).

## Anatomy (steps)

- **Entry** (required) — sign-in with credentials or a passwordless start.
- **Verification** (conditional) — a second factor or one-time code step.
- **Recovery** (conditional) — request reset, confirm via link/code, set a new
  password.
- **Provider/SSO** (optional) — hand-off to an identity provider and back.
- **Success / redirect** (required) — land the user where they intended to go.
- **Feedback** (required) — clear errors, lockout, and rate-limit messaging.

## States & behavior

- **Step progression** — the flow advances only when a step succeeds.
- **Errors** — invalid credentials, expired codes, and locked accounts are
  communicated clearly and safely.
- **Interruptions** — deep links resume to the right step; the intended
  destination is preserved and honored after success.
- **Session** — establishes the session and respects "remember me".
- **Step-up** — sensitive actions can re-trigger a lightweight re-auth.

## Variants

- **Password + optional 2FA**.
- **Passwordless** — magic link or one-time code.
- **SSO-first** — provider hand-off with an email fallback.
- **Reset password** — a self-contained recovery sub-flow.

## Layout & responsiveness

Each step is a focused, centered screen (or dialog for step-up), minimizing
distraction. Progress between steps is evident, and the flow is comfortable on
small screens where auth most often happens.

## Accessibility

- **Per-step semantics** — each screen's form and errors follow the form/field
  contract; focus moves to the first error on failure.
- **Code entry** — one-time-code steps support paste and OS autofill.
- **Announcements** — step changes and errors are announced without stealing focus
  disruptively.
- **Recovery** — reset paths are fully keyboard-accessible and clearly labeled.

## Content guidelines

- Ask only for what's needed at each step.
- Use a single, non-revealing error for failed authentication.
- Make recovery and provider options easy to find.

## Composition

**Composed of:** sign-in, form, field, input, input-otp, button, alert, link.

**Used by:** Not applicable — a top-level journey; precedes protected experiences.

## Do / Don't

**Do**
- Preserve the intended destination and resume there after success.
- Keep failures safe and actionable.

**Don't**
- Leak whether an account exists via differential responses.
- Force unnecessary steps for legitimate returning users.

## References

- OWASP — authentication and session management guidance.
- WCAG — Error Identification; Labels or Instructions.
