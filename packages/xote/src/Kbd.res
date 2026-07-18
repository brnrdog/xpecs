// Kbd — an inline keyboard-key glyph. Reused by command and shortcut hints.
@jsx.component
let make = (~children: View.node) =>
  <span
    class="inline-flex min-w-6 items-center justify-center rounded border border-neutral-300 bg-neutral-50 px-1.5 py-0.5 font-mono text-xs text-neutral-700 shadow-[0_1px_0_theme(colors.neutral.300)]">
    {children}
  </span>
