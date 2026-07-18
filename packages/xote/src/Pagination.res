// Pagination — numbered page controls bound to a signal. Implements the
// `pagination` spec.
@jsx.component
let make = (~page: Signal.t<int>, ~total: int) => {
  let pages = Array.fromInitializer(~length=total, i => i + 1)
  let navBtn = "inline-flex size-9 items-center justify-center rounded-md text-sm transition-colors"
  <div class="flex items-center gap-1">
    <button
      class={navBtn ++ " border border-neutral-300 text-neutral-700 hover:bg-neutral-100"}
      onClick={_ => Signal.update(page, p => p > 1 ? p - 1 : 1)}>
      <View.Text> "‹" </View.Text>
    </button>
    <View.For
      each={Prop.static(pages)}
      render={p => {
        let cls = Computed.make(() =>
          navBtn ++ (
            Signal.get(page) == p ? " bg-neutral-900 text-neutral-0" : " text-neutral-700 hover:bg-neutral-100"
          )
        )
        <button class={Prop.signal(cls)} onClick={_ => Signal.set(page, p)}>
          <View.Text> {Int.toString(p)} </View.Text>
        </button>
      }}
    />
    <button
      class={navBtn ++ " border border-neutral-300 text-neutral-700 hover:bg-neutral-100"}
      onClick={_ => Signal.update(page, p => p < total ? p + 1 : total)}>
      <View.Text> "›" </View.Text>
    </button>
  </div>
}
