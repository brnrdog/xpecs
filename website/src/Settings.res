// Live theme settings. The whole site is driven by the design tokens compiled to
// CSS custom properties (see tokens.generated.css), so re-theming at runtime is
// just overriding those variables on :root. Presets and per-token edits share one
// path→value override store, persisted in localStorage and re-applied on load.

// --- Raw DOM / storage helpers -------------------------------------------------
let setVar: (string, string) => unit = %raw(`(k, v) => document.documentElement.style.setProperty(k, v)`)
let removeVar: string => unit = %raw(`(k) => document.documentElement.style.removeProperty(k)`)
let store: (string, string) => unit = %raw(`(k, v) => { try { localStorage.setItem(k, v) } catch (e) {} }`)
let read: string => string = %raw(`(k) => { try { return localStorage.getItem(k) || "" } catch (e) { return "" } }`)
let reload: unit => unit = %raw(`() => location.reload()`)
let readOr = (k, d) => {
  let v = read(k)
  v == "" ? d : v
}

// --- Token override store (path → value) ---------------------------------------
// Shared by the preset picker and the Design Tokens editor. Editing overrides the
// token's Tailwind theme var (cascades site-wide) and its --ux-* mirror.
let getOverrides: unit => Dict.t<string> = %raw(`() => { try { return JSON.parse(localStorage.getItem("ux.tokenOverrides") || "{}") } catch (e) { return {} } }`)
let saveOverrides: Dict.t<string> => unit = %raw(`(o) => { try { localStorage.setItem("ux.tokenOverrides", JSON.stringify(o)) } catch (e) {} }`)

let tokenByPath = path => {
  let found = ref(None)
  TokensData.all->Array.forEach(g =>
    g.tokens->Array.forEach(t =>
      if t.path == path {
        found := Some(t)
      }
    )
  )
  found.contents
}

let applyVars = (t: TokensData.token, value) => {
  setVar(t.uxVar, value)
  if t.themeVar != "" {
    setVar(t.themeVar, value)
  }
}

let applyToken = (t: TokensData.token, value) => {
  applyVars(t, value)
  let o = getOverrides()
  o->Dict.set(t.path, value)
  saveOverrides(o)
}

let applyByPath = (path, value) =>
  switch tokenByPath(path) {
  | Some(t) => applyToken(t, value)
  | None => ()
  }

let loadTokenOverrides = () => {
  let o = getOverrides()
  o
  ->Dict.toArray
  ->Array.forEach(((path, v)) =>
    switch tokenByPath(path) {
    | Some(t) => applyVars(t, v)
    | None => ()
    }
  )
}

// Remove every current override's inline vars and clear the store.
let clearOverrides = () => {
  let o = getOverrides()
  o
  ->Dict.keysToArray
  ->Array.forEach(path =>
    switch tokenByPath(path) {
    | Some(t) =>
      removeVar(t.uxVar)
      if t.themeVar != "" {
        removeVar(t.themeVar)
      }
    | None => ()
    }
  )
  saveOverrides(Dict.make())
}

// --- Presets -------------------------------------------------------------------
// A preset is a named bundle of token overrides. Tinting the neutral ramp
// cascades through the semantic roles (which alias it) so the whole site — chrome
// and components — re-themes cohesively; a couple also override a semantic role
// directly. Applying one replaces any current overrides.
let inter = `Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif`
let serif = `Georgia, Cambria, "Times New Roman", serif`
let mono = `ui-monospace, SFMono-Regular, Menlo, Consolas, monospace`

// Tint both ends of the neutral ramp: the light steps (50/100/200) drive
// backgrounds, borders, and subtle surfaces, and the dark steps (700–950) drive
// text, accents, and fills. The mid greys (300–600) are left neutral so muted
// text and placeholders stay readable on the tinted background.
let tintEnds = (l50, l100, l200, d700, d800, d900, d950) => [
  ("color.neutral.50", l50),
  ("color.neutral.100", l100),
  ("color.neutral.200", l200),
  ("color.neutral.700", d700),
  ("color.neutral.800", d800),
  ("color.neutral.900", d900),
  ("color.neutral.950", d950),
]
let radiusPairs = id =>
  switch id {
  | "sharp" => [("radius.sm", "0.125rem"), ("radius.md", "0.1875rem"), ("radius.lg", "0.25rem"), ("radius.xl", "0.375rem"), ("radius.2xl", "0.5rem"), ("radius.3xl", "0.75rem")]
  | "rounded" => [("radius.sm", "0.5rem"), ("radius.md", "0.75rem"), ("radius.lg", "1rem"), ("radius.xl", "1.5rem"), ("radius.2xl", "2rem"), ("radius.3xl", "2.5rem")]
  | _ => [("radius.sm", "0.375rem"), ("radius.md", "0.5rem"), ("radius.lg", "0.75rem"), ("radius.xl", "1rem"), ("radius.2xl", "1.25rem"), ("radius.3xl", "1.75rem")]
  }
let fontPair = stack => [("font.family.sans", stack)]
// Functional (intent) colors used across components: the primary action and the
// four feedback statuses (info / success / warning / danger).
let actionPair = (def, hover, on_) => [
  ("color.action.default", def),
  ("color.action.hover", hover),
  ("color.action.onAction", on_),
]
let statusPair = (info, success, warning, danger) => [
  ("color.status.info", info),
  ("color.status.success", success),
  ("color.status.warning", warning),
  ("color.status.danger", danger),
]

type preset = {id: string, label: string, swatches: array<string>, pairs: array<(string, string)>}

let presets: array<preset> = [
  {id: "monochrome", label: "Monochrome", swatches: ["#171717"], pairs: []},
  {
    id: "indigo",
    label: "Indigo",
    swatches: ["#eef2ff", "#4f46e5", "#312e81"],
    pairs: [
      ...tintEnds("#eef2ff", "#e0e7ff", "#c7d2fe", "#4338ca", "#3730a3", "#312e81", "#1e1b4b"),
      ...actionPair("#4f46e5", "#4338ca", "#ffffff"),
      ...radiusPairs("rounded"),
      ...fontPair(inter),
    ],
  },
  {
    id: "forest",
    label: "Forest",
    swatches: ["#ecfdf5", "#059669", "#064e3b"],
    pairs: [
      ...tintEnds("#ecfdf5", "#d1fae5", "#a7f3d0", "#047857", "#065f46", "#064e3b", "#022c22"),
      ...actionPair("#059669", "#047857", "#ffffff"),
      ...radiusPairs("default"),
      ...fontPair(inter),
    ],
  },
  {
    id: "editorial",
    label: "Editorial",
    swatches: ["#fafaf9", "#44403c", "#1c1917"],
    pairs: [
      ...tintEnds("#fafaf9", "#f5f5f4", "#e7e5e4", "#44403c", "#292524", "#1c1917", "#0c0a09"),
      ...actionPair("#292524", "#1c1917", "#fafaf9"),
      ...radiusPairs("sharp"),
      ...fontPair(serif),
    ],
  },
  {
    id: "terminal",
    label: "Terminal",
    swatches: ["#f0fdf4", "#16a34a", "#14532d"],
    pairs: [
      ...tintEnds("#f0fdf4", "#dcfce7", "#bbf7d0", "#166534", "#14532d", "#052e16", "#031a0d"),
      ...actionPair("#16a34a", "#15803d", "#ffffff"),
      ...radiusPairs("sharp"),
      ...fontPair(mono),
    ],
  },
  {
    id: "sunset",
    label: "Sunset",
    swatches: ["#fff7ed", "#ea580c", "#7c2d12"],
    pairs: [
      ...tintEnds("#fff7ed", "#ffedd5", "#fed7aa", "#c2410c", "#9a3412", "#7c2d12", "#431407"),
      ...actionPair("#ea580c", "#c2410c", "#ffffff"),
      ...radiusPairs("rounded"),
      ...fontPair(inter),
    ],
  },
  // Functional palettes — set the intent colors too, so buttons and every
  // status surface (alerts, badges) pick up a full, purposeful palette.
  {
    id: "vibrant",
    label: "Vibrant",
    swatches: ["#7c3aed", "#2563eb", "#16a34a", "#d97706", "#dc2626"],
    pairs: [
      ...tintEnds("#f5f3ff", "#ede9fe", "#ddd6fe", "#6d28d9", "#5b21b6", "#4c1d95", "#2e1065"),
      ...actionPair("#7c3aed", "#6d28d9", "#ffffff"),
      ...statusPair("#2563eb", "#16a34a", "#d97706", "#dc2626"),
      ...radiusPairs("rounded"),
      ...fontPair(inter),
    ],
  },
  {
    id: "ocean",
    label: "Ocean",
    swatches: ["#0891b2", "#0284c7", "#059669", "#ca8a04", "#e11d48"],
    pairs: [
      ...tintEnds("#ecfeff", "#cffafe", "#a5f3fc", "#0e7490", "#155e75", "#164e63", "#083344"),
      ...actionPair("#0891b2", "#0e7490", "#ffffff"),
      ...statusPair("#0284c7", "#059669", "#ca8a04", "#e11d48"),
      ...radiusPairs("default"),
      ...fontPair(inter),
    ],
  },
  {
    id: "coral",
    label: "Coral",
    swatches: ["#e11d48", "#0891b2", "#65a30d", "#d97706", "#dc2626"],
    pairs: [
      ...tintEnds("#fff1f2", "#ffe4e6", "#fecdd3", "#be123c", "#9f1239", "#881337", "#4c0519"),
      ...actionPair("#e11d48", "#be123c", "#ffffff"),
      ...statusPair("#0891b2", "#65a30d", "#d97706", "#dc2626"),
      ...radiusPairs("rounded"),
      ...fontPair(inter),
    ],
  },
]

// --- State ---------------------------------------------------------------------
let open_ = Signal.make(false)
let presetSel = Signal.make(readOr("ux.preset", "monochrome"))

let applyPreset = p => {
  clearOverrides()
  p.pairs->Array.forEach(((path, v)) => applyByPath(path, v))
  Signal.set(presetSel, p.id)
  store("ux.preset", p.id)
}

// Reset everything (presets + per-token edits) back to the framework defaults.
let resetTokens = () => {
  clearOverrides()
  Signal.set(presetSel, "monochrome")
  store("ux.preset", "monochrome")
}
let resetTokensAndReload = () => {
  resetTokens()
  reload()
}

// --- UI ------------------------------------------------------------------------
module Trigger = {
  @jsx.component
  let make = () =>
    <IconButton label="Theme settings" onClick={_ => Signal.update(open_, v => !v)}>
      <span class="text-base"> <View.Text> "⚙" </View.Text> </span>
    </IconButton>
}

module Panel = {
  @jsx.component
  let make = () => {
    // Close on Escape while open.
    Effect.run(() =>
      if Signal.get(open_) {
        Some(Ui.onEscape(() => Signal.set(open_, false)))
      } else {
        None
      }
    )
    <View.Show when_={Prop.signal(open_)}>
      <Backdrop onClose={() => Signal.set(open_, false)} />
      <div class="fixed right-3 top-16 z-40 w-72 rounded-2xl border border-border bg-surface p-4 shadow-2xl">
        <div class="flex items-center justify-between">
          <h2 class="text-sm font-semibold text-ink"> <View.Text> "Theme presets" </View.Text> </h2>
          <span class="text-xs text-muted"> <View.Text> "live tokens" </View.Text> </span>
        </div>

        <div class="mt-3 grid grid-cols-3 gap-2">
          <View.For
            each={Prop.static(presets)}
            render={p => {
              let cls = Computed.make(() =>
                "flex flex-col items-center gap-1.5 rounded-xl border p-2 transition-colors " ++ (
                  Signal.get(presetSel) == p.id
                    ? "border-neutral-900 bg-action-subtle"
                    : "border-border hover:bg-action-subtle"
                )
              )
              <button class={Prop.signal(cls)} onClick={_ => applyPreset(p)}>
                {Array.length(p.swatches) == 1
                  ? <span
                      class="size-6 rounded-full ring-1 ring-black/10"
                      style={"background-color: " ++ Array.getUnsafe(p.swatches, 0)}
                    />
                  : <span class="flex h-6 overflow-hidden rounded-full ring-1 ring-black/10">
                      <View.For
                        each={Prop.static(p.swatches)}
                        render={c => <span class="w-1.5" style={"background-color: " ++ c} />}
                      />
                    </span>}
                <span class="text-[11px] font-medium text-ink"> <View.Text> {p.label} </View.Text> </span>
              </button>
            }}
          />
        </div>

        <button
          class="mt-4 block text-xs text-muted underline decoration-neutral-300 underline-offset-2 hover:text-ink"
          onClick={_ => {
            Signal.set(open_, false)
            Router.push("/tokens", ())
          }}>
          <View.Text> "Edit individual tokens →" </View.Text>
        </button>

        <div class="mt-4 flex items-center justify-between border-t border-border pt-3">
          <Button variant=#ghost size=#sm onClick={_ => resetTokens()}>
            <View.Text> "Reset" </View.Text>
          </Button>
          <span class="flex items-center gap-1 text-xs text-muted">
            <Kbd> <View.Text> "esc" </View.Text> </Kbd>
            <View.Text> "to close" </View.Text>
          </span>
        </div>
      </div>
    </View.Show>
  }
}
