// Reusable Xote components — the shared building blocks the archetype examples
// compose. Encapsulate the monochrome token-driven classes from Ui so higher
// level examples (card, dialog, form, navbar, …) reuse them instead of
// repeating markup.

module Backdrop = {
  @jsx.component
  let make = (~onClose) => <div class="fixed inset-0 z-10" onClick={_ => onClose()} />
}

type buttonVariant = [#primary | #secondary | #ghost | #destructive]

module Button = {
  @jsx.component
  let make = (
    ~variant: buttonVariant=#primary,
    ~type_: string="button",
    ~disabled: bool=false,
    ~onClick: option<Dom.event => unit>=?,
    ~extraClass: string="",
    ~children: View.node,
  ) => {
    let base = switch variant {
    | #primary => Ui.btnPrimary
    | #secondary => Ui.btnSecondary
    | #ghost => Ui.btnGhost
    | #destructive => Ui.btnDestructive
    }
    <button type_ disabled class={base ++ (extraClass == "" ? "" : " " ++ extraClass)} ?onClick>
      {children}
    </button>
  }
}

type badgeVariant = [#solid | #soft | #outline]

module Badge = {
  @jsx.component
  let make = (~variant: badgeVariant=#solid, ~children: View.node) => {
    let tone = switch variant {
    | #solid => "bg-neutral-900 text-white"
    | #soft => "bg-neutral-200 text-neutral-800"
    | #outline => "border border-neutral-300 text-neutral-700"
    }
    <span class={"inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium " ++ tone}>
      {children}
    </span>
  }
}

module Input = {
  @jsx.component
  let make = (
    ~type_: string="text",
    ~id: option<string>=?,
    ~placeholder: string="",
    ~value: option<string>=?,
    ~required: bool=false,
    ~onInput: option<Dom.event => unit>=?,
    ~extraClass: string="",
  ) =>
    <input
      type_
      ?id
      placeholder
      required
      ?value
      ?onInput
      class={Ui.inputBase ++ (extraClass == "" ? "" : " " ++ extraClass)}
    />
}

module Field = {
  @jsx.component
  let make = (~label: string, ~for_: string, ~hint: string="", ~children: View.node) =>
    <div class="space-y-1.5">
      <label class={Ui.label} for_> <View.Text> {label} </View.Text> </label>
      {children}
      {hint == ""
        ? View.null()
        : <p class="text-xs text-neutral-500"> <View.Text> {hint} </View.Text> </p>}
    </div>
}

module Avatar = {
  @jsx.component
  let make = (~initials: string, ~size: string="size-10 text-sm") =>
    <span
      class={"inline-flex items-center justify-center overflow-hidden rounded-full bg-neutral-200 font-medium text-neutral-700 ring-2 ring-white " ++
      size}>
      <View.Text> {initials} </View.Text>
    </span>
}

type spinnerTone = [#ink | #onAccent]

module Spinner = {
  @jsx.component
  let make = (~size: string="size-4", ~tone: spinnerTone=#ink) => {
    let colors = switch tone {
    | #ink => "border-neutral-300 border-t-neutral-900"
    | #onAccent => "border-white/40 border-t-white"
    }
    <span class={"inline-block animate-spin rounded-full border-2 " ++ colors ++ " " ++ size} />
  }
}

module Switch = {
  @jsx.component
  let make = (~on: Signal.t<bool>, ~label: string="") => {
    let track = Computed.make(() =>
      "relative inline-flex h-6 w-11 items-center rounded-full transition-colors " ++ (
        Signal.get(on) ? "bg-neutral-900" : "bg-neutral-300"
      )
    )
    let knob = Computed.make(() =>
      "inline-block size-5 transform rounded-full bg-white shadow transition-transform " ++ (
        Signal.get(on) ? "translate-x-5" : "translate-x-0.5"
      )
    )
    <label class="flex items-center gap-3">
      <button
        type_="button" role="switch" class={Prop.signal(track)} onClick={_ => Signal.update(on, v => !v)}>
        <span class={Prop.signal(knob)} />
      </button>
      {label == ""
        ? View.null()
        : <span class="text-sm text-neutral-800"> <View.Text> {label} </View.Text> </span>}
    </label>
  }
}

module Kbd = {
  @jsx.component
  let make = (~children: View.node) =>
    <span
      class="inline-flex min-w-6 items-center justify-center rounded border border-neutral-300 bg-neutral-50 px-1.5 py-0.5 font-mono text-xs text-neutral-700 shadow-[0_1px_0_theme(colors.neutral.300)]">
      {children}
    </span>
}

type separatorOrientation = [#horizontal | #vertical]

module Separator = {
  @jsx.component
  let make = (~orientation: separatorOrientation=#horizontal, ~extraClass: string="") => {
    let base = switch orientation {
    | #horizontal => "h-px w-full bg-neutral-200"
    | #vertical => "h-4 w-px bg-neutral-200"
    }
    <div class={base ++ (extraClass == "" ? "" : " " ++ extraClass)} role="separator" />
  }
}

module Card = {
  @jsx.component
  let make = (~extraClass: string="", ~children: View.node) =>
    <div class={Ui.card ++ (extraClass == "" ? "" : " " ++ extraClass)}> {children} </div>
}
