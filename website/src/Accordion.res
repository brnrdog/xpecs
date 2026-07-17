// Accordion — a stack of headers that expand/collapse their panels. `type`
// (from the contract) selects single- vs multiple-open behavior; `collapsible`
// controls whether the open panel can be closed again. Open state is the set of
// open ids held in the `value` signal.
@jsx.component
let make = (
  ~type_: Contracts.Accordion.type_=#single,
  ~collapsible: bool=true,
  ~value: Signal.t<array<string>>,
  ~items: array<(string, string, string)>,
) => {
  let toggle = id =>
    Signal.update(value, cur => {
      let isOpen = cur->Array.includes(id)
      switch (type_, isOpen) {
      | (_, true) => collapsible ? cur->Array.filter(x => x != id) : cur
      | (#single, false) => [id]
      | (#multiple, false) => cur->Array.concat([id])
      }
    })
  <div class="w-96 divide-y divide-neutral-200 rounded-lg border border-neutral-200">
    <View.For
      each={Prop.static(items)}
      render={item => {
        let (id, header, panel) = item
        let isOpen = Computed.make(() => Signal.get(value)->Array.includes(id))
        let mark = Computed.make(() => Signal.get(value)->Array.includes(id) ? "−" : "+")
        <div>
          <button
            class="flex w-full items-center justify-between px-4 py-3 text-left text-sm font-medium text-neutral-800 hover:bg-neutral-50"
            onClick={_ => toggle(id)}>
            <View.Text> header </View.Text>
            <span class="text-neutral-400"> <View.Text> {mark} </View.Text> </span>
          </button>
          <View.Show when_={Prop.signal(isOpen)}>
            <p class="px-4 pb-3 text-sm text-neutral-500"> <View.Text> panel </View.Text> </p>
          </View.Show>
        </div>
      }}
    />
  </div>
}
