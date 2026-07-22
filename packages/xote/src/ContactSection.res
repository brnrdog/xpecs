// Contact Section — a short message form beside direct contact channels.
// Field values live in internal signals; submit prevents the default, hands
// (name, email, message) to `onSubmit`, and shows the success confirmation in
// place (the `contact-section` spec's success state) with a status region so
// the outcome is announced. Each detail is (icon, label, href) and renders as
// a real link (mailto:, tel:, …). The two columns stack, form first, on
// narrow containers (the contract's `stack` reflow).
@jsx.component
let make = (
  ~heading: string,
  ~description: string="",
  ~details: array<(string, string, string)>=[],
  ~onSubmit: option<((string, string, string)) => unit>=?,
) => {
  let name = Signal.make("")
  let email = Signal.make("")
  let message = Signal.make("")
  let sent = Signal.make(false)
  let submit = evt => {
    Ui.preventDefault(evt)
    switch onSubmit {
    | Some(fn) => fn((Signal.get(name), Signal.get(email), Signal.get(message)))
    | None => ()
    }
    Signal.set(sent, true)
  }
  <section class="grid w-full gap-10 md:grid-cols-5">
    <div class="md:col-span-3">
      <h2 class="text-2xl font-semibold tracking-tight text-ink">
        <View.Text> heading </View.Text>
      </h2>
      {description == ""
        ? View.null()
        : <p class="mt-2 text-sm text-muted"> <View.Text> description </View.Text> </p>}
      <form class="mt-6 space-y-4" onSubmit=submit>
        <div class="grid gap-4 sm:grid-cols-2">
          <Field label="Name" for_="contact-name">
            <Input
              id="contact-name"
              placeholder="Ada Lovelace"
              required=true
              onInput={e => Signal.set(name, Ui.inputValue(e))}
            />
          </Field>
          <Field label="Email" for_="contact-email">
            <Input
              id="contact-email"
              type_="email"
              placeholder="ada@example.com"
              required=true
              onInput={e => Signal.set(email, Ui.inputValue(e))}
            />
          </Field>
        </div>
        <Field label="Message" for_="contact-message">
          <textarea
            id="contact-message"
            rows=4
            required=true
            class={Ui.inputBase ++ " resize-none"}
            placeholder="How can we help?"
            onInput={e => Signal.set(message, Ui.inputValue(e))}
          />
        </Field>
        <Button type_=#submit variant=#primary>
          <View.Text> "Send message" </View.Text>
        </Button>
        <div role="status">
          <View.Show when_={Prop.signal(sent)}>
            <p class="rounded-md bg-action-subtle px-3 py-2 text-sm text-ink">
              <View.Text> "Thanks — your message is on its way. We reply within one business day." </View.Text>
            </p>
          </View.Show>
        </div>
      </form>
    </div>
    {details->Array.length == 0
      ? View.null()
      : <ul class="space-y-4 md:col-span-2 md:pt-12">
          <View.For
            each={Prop.static(details)}
            render={detail => {
              let (icon, label, href) = detail
              <li>
                <a href class="group inline-flex items-center gap-3 text-sm text-ink">
                  <span
                    class="flex size-9 items-center justify-center rounded-lg border border-border bg-surface text-muted">
                    <Icon name=icon />
                  </span>
                  <span class="group-hover:underline"> <View.Text> label </View.Text> </span>
                </a>
              </li>
            }}
          />
        </ul>}
  </section>
}
