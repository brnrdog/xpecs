// GENERATED FILE — do not edit by hand.
// Run `npm run responsive` (scripts/generate-responsive.mjs) to regenerate.
// Source of truth: ../../responsive/patterns.json.

type pattern = {
  id: string,
  label: string,
  description: string,
}

let patterns: array<pattern> = [
  { id: "fluid", label: "Fluid", description: "Fills the width of its container and grows/shrinks continuously; no structural change." },
  { id: "wrap", label: "Wrap", description: "A row of items wraps onto additional lines as width decreases, rather than overflowing or shrinking each item." },
  { id: "stack", label: "Stack", description: "A horizontal arrangement becomes a vertical stack below the breakpoint." },
  { id: "reflow-columns", label: "Reflow columns", description: "A multi-column grid steps its column count down as width decreases (e.g. 3 → 2 → 1)." },
  { id: "collapse-to-menu", label: "Collapse to menu", description: "Lower-priority items collapse behind a disclosure or overflow control (hamburger, ‘More’ menu) when they no longer fit." },
  { id: "drawer", label: "Drawer", description: "A persistent side region (sidebar, nav) becomes a toggled, off-canvas drawer over the content." },
  { id: "to-sheet", label: "To sheet", description: "A centered or anchored overlay becomes a full-width edge sheet (typically bottom) on small screens for reachability." },
  { id: "horizontal-scroll", label: "Horizontal scroll", description: "Content that can't compress overflows into a horizontal scroller with clear affordance, instead of clipping." },
  { id: "reflow-to-cards", label: "Reflow to cards", description: "Dense tabular rows restructure into a stack of label/value cards below the breakpoint." },
  { id: "reposition", label: "Reposition", description: "An anchored surface flips or shifts its placement to stay within the viewport as space runs out." },
  { id: "truncate", label: "Truncate", description: "Text or labels ellipsize (or drop to an icon) rather than wrap or push the layout." },
  { id: "hide-secondary", label: "Hide secondary", description: "Non-essential elements are hidden below the breakpoint, keeping the essential content legible." },
]

let find = id => patterns->Array.find(p => p.id == id)
let labelFor = id =>
  switch find(id) {
  | Some(p) => p.label
  | None => id
  }
