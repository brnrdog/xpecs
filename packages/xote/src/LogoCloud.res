// Logo Cloud — a quiet band of customer/partner marks that lends credibility
// at a glance. Marks are rendered as optically-equal wordmarks in a single
// muted tone so no brand dominates and the band stays quieter than the content
// around it; each carries its company name for assistive tech. The row wraps
// onto more lines as the container narrows (the `logo-cloud` spec's `wrap`
// reflow) rather than shrinking the marks.
@jsx.component
let make = (~heading: string="", ~logos: array<string>) =>
  <section class="w-full py-6 text-center">
    {heading == ""
      ? View.null()
      : <p class="mb-5 text-xs font-medium uppercase tracking-widest text-muted">
          <View.Text> heading </View.Text>
        </p>}
    <ul class="flex flex-wrap items-center justify-center gap-x-10 gap-y-5">
      <View.For
        each={Prop.static(logos)}
        render={name =>
          <li>
            <span
              role="img"
              ariaLabel=name
              class="text-lg font-semibold tracking-tight text-neutral-400 select-none">
              <View.Text> name </View.Text>
            </span>
          </li>}
      />
    </ul>
  </section>
