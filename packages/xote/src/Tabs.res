// Tabs — a tablist whose selected tab drives a panel. Controlled via a `value`
// signal (the active tab id); `orientation` comes from the contract type. The
// panel is rendered by the caller from the same signal. Exposes roving focus
// via native tab semantics (see the `roving-focus` trait).
@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~orientation: Contracts.Tabs.orientation=#horizontal,
  ~tabs: array<(string, string)>,
) => {
  let listCls = switch orientation {
  | #horizontal => "flex gap-1 border-b border-neutral-200"
  | #vertical => "flex flex-col gap-1 border-r border-neutral-200"
  }
  <div role="tablist" class={listCls}>
    <View.For
      each={Prop.static(tabs)}
      render={item => {
        let (id, label) = item
        let cls = Computed.make(() => {
          let active = Signal.get(value) == id
          "-mb-px border-b-2 px-4 py-2 text-sm font-medium transition-colors " ++ (
            active
              ? "border-neutral-900 text-neutral-900"
              : "border-transparent text-neutral-500 hover:text-neutral-800"
          )
        })
        <button role="tab" class={Prop.signal(cls)} onClick={_ => Signal.set(value, id)}>
          <View.Text> label </View.Text>
        </button>
      }}
    />
  </div>
}
