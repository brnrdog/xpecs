// Collapsible — a single region that expands/collapses to show or hide content.
// Controlled via an `open_` signal (the contract's `open` prop); the trigger
// label and the collapsible content are passed in. Reuses Button.
@jsx.component
let make = (~open_: Signal.t<bool>, ~label: string, ~children: View.node) => {
  let caret = Computed.make(() => Signal.get(open_) ? "⌃" : "⌄")
  <div class="w-80 space-y-2">
    <Button
      variant=#secondary
      extraClass="w-full justify-between"
      onClick={_ => Signal.update(open_, v => !v)}>
      <View.Text> label </View.Text>
      <span class="text-neutral-400"> <View.Text> {caret} </View.Text> </span>
    </Button>
    <View.Show when_={Prop.signal(open_)}>
      <div class="rounded-md border border-neutral-200 p-3 text-sm text-neutral-600">
        {children}
      </div>
    </View.Show>
  </div>
}
