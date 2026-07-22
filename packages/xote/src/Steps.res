// Steps — an ordered "how it works" sequence: numbered markers, a short title
// and one line of description per step, tied together by connectors. The
// `orientation` type comes from the spec's `## API` contract (Contracts.res).
// Order is carried by the list semantics — markers and connectors are
// decorative. Horizontal steps stack into the vertical form on narrow
// containers (the contract's `stack` reflow).
@jsx.component
let make = (
  ~orientation: Contracts.Steps.orientation=#horizontal,
  ~heading: string="",
  ~steps: array<(string, string)>,
) => {
  let numbered = steps->Array.mapWithIndex((step, i) => {
    let (title, description) = step
    (Int.toString(i + 1), title, description, i == Array.length(steps) - 1)
  })
  let listCls = switch orientation {
  | #horizontal => "flex flex-col gap-8 md:flex-row md:gap-6"
  | #vertical => "flex flex-col gap-8"
  }
  <section class="w-full">
    {heading == ""
      ? View.null()
      : <h2 class="mb-8 text-center text-2xl font-semibold tracking-tight text-ink">
          <View.Text> heading </View.Text>
        </h2>}
    <ol class=listCls>
      <View.For
        each={Prop.static(numbered)}
        render={step => {
          let (number, title, description, isLast) = step
          <li class="relative flex gap-4 md:flex-1">
            <div class="flex flex-col items-center" ariaHidden="true">
              <span
                class="flex size-8 shrink-0 items-center justify-center rounded-full border border-border bg-surface text-sm font-semibold text-ink">
                <View.Text> number </View.Text>
              </span>
              // The vertical connector between markers; the last step ends the path.
              <View.Show when_={Prop.static(!isLast && orientation == #vertical)}>
                <span class="mt-2 w-px flex-1 bg-border" />
              </View.Show>
            </div>
            <div class="pb-2">
              <p class="text-sm font-semibold text-ink"> <View.Text> title </View.Text> </p>
              <p class="mt-1 text-sm text-muted"> <View.Text> description </View.Text> </p>
            </div>
          </li>
        }}
      />
    </ol>
  </section>
}
