// Newsletter — a one-field email-capture band. The field and its button act
// as one composite control (the input-group pattern) and stack on narrow
// containers (the `newsletter` spec's `stack` reflow). Submit prevents the
// default, hands the address to `onSubscribe`, and swaps the form for an
// announced confirmation — the spec's success state. The visible heading and
// an explicit ariaLabel keep the field labelled without a floating label.
@jsx.component
let make = (
  ~heading: string,
  ~description: string="",
  ~consent: string="",
  ~onSubscribe: option<string => unit>=?,
) => {
  let email = Signal.make("")
  let done_ = Signal.make(false)
  let submit = evt => {
    Ui.preventDefault(evt)
    switch onSubscribe {
    | Some(fn) => fn(Signal.get(email))
    | None => ()
    }
    Signal.set(done_, true)
  }
  let pending = Computed.make(() => !Signal.get(done_))
  <section class="w-full rounded-2xl border border-border bg-surface p-8 text-center">
    <h2 class="text-xl font-semibold tracking-tight text-ink">
      <View.Text> heading </View.Text>
    </h2>
    {description == ""
      ? View.null()
      : <p class="mt-1 text-sm text-muted"> <View.Text> description </View.Text> </p>}
    <View.Show when_={Prop.signal(pending)}>
      <form class="mx-auto mt-5 flex w-full max-w-md flex-col gap-2 sm:flex-row" onSubmit=submit>
        <input
          type_="email"
          required=true
          ariaLabel="Email address"
          placeholder="you@example.com"
          class={Ui.inputBase ++ " flex-1"}
          onInput={e => Signal.set(email, Ui.inputValue(e))}
        />
        <Button type_=#submit variant=#primary>
          <View.Text> "Subscribe" </View.Text>
        </Button>
      </form>
    </View.Show>
    <div role="status">
      <View.Show when_={Prop.signal(done_)}>
        <p class="mx-auto mt-5 flex max-w-md items-center justify-center gap-2 text-sm text-ink">
          <span class="text-status-success"> <Icon name="check-circle" /> </span>
          <View.Text> "Almost there — check your inbox to confirm." </View.Text>
        </p>
      </View.Show>
    </div>
    {consent == ""
      ? View.null()
      : <p class="mt-3 text-xs text-muted"> <View.Text> consent </View.Text> </p>}
  </section>
}
