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

let nramp = (a, b, c, d) => [
  ("color.neutral.700", a),
  ("color.neutral.800", b),
  ("color.neutral.900", c),
  ("color.neutral.950", d),
]
let radiusPairs = id =>
  switch id {
  | "sharp" => [("radius.sm", "0.125rem"), ("radius.md", "0.1875rem"), ("radius.lg", "0.25rem"), ("radius.xl", "0.375rem"), ("radius.2xl", "0.5rem"), ("radius.3xl", "0.75rem")]
  | "rounded" => [("radius.sm", "0.5rem"), ("radius.md", "0.75rem"), ("radius.lg", "1rem"), ("radius.xl", "1.5rem"), ("radius.2xl", "2rem"), ("radius.3xl", "2.5rem")]
  | _ => [("radius.sm", "0.375rem"), ("radius.md", "0.5rem"), ("radius.lg", "0.75rem"), ("radius.xl", "1rem"), ("radius.2xl", "1.25rem"), ("radius.3xl", "1.75rem")]
  }
let fontPair = stack => [("font.family.sans", stack)]

type preset = {id: string, label: string, swatch: string, pairs: array<(string, string)>}

let presets: array<preset> = [
  {id: "monochrome", label: "Monochrome", swatch: "#171717", pairs: []},
  {
    id: "indigo",
    label: "Indigo",
    swatch: "#3730a3",
    pairs: [...nramp("#4338ca", "#3730a3", "#312e81", "#1e1b4b"), ...radiusPairs("rounded"), ...fontPair(inter)],
  },
  {
    id: "forest",
    label: "Forest",
    swatch: "#065f46",
    pairs: [...nramp("#047857", "#065f46", "#064e3b", "#022c22"), ...radiusPairs("default"), ...fontPair(inter)],
  },
  {
    id: "editorial",
    label: "Editorial",
    swatch: "#292524",
    pairs: [...nramp("#44403c", "#292524", "#1c1917", "#0c0a09"), ...radiusPairs("sharp"), ...fontPair(serif)],
  },
  {
    id: "terminal",
    label: "Terminal",
    swatch: "#16a34a",
    pairs: [
      ...nramp("#374151", "#1f2937", "#111827", "#030712"),
      ...radiusPairs("sharp"),
      ...fontPair(mono),
      ("color.action.default", "#16a34a"),
      ("color.action.hover", "#15803d"),
      ("color.action.onAction", "#ffffff"),
    ],
  },
  {
    id: "sunset",
    label: "Sunset",
    swatch: "#9a3412",
    pairs: [...nramp("#c2410c", "#9a3412", "#7c2d12", "#431407"), ...radiusPairs("rounded"), ...fontPair(inter)],
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
                <span class="size-6 rounded-full ring-1 ring-black/10" style={"background-color: " ++ p.swatch} />
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
