// Announcement Bar — a slim, page-width strip carrying one timely message,
// with an optional action link and a dismiss control. The `variant` type
// comes from the spec's `## API` contract (Contracts.res): neutral blends
// with the chrome, accent uses the promotional fill, warning keeps a neutral
// surface with a status-toned border + icon (the same monochrome move as
// Alert). Dismissal hides the bar and notifies `onDismiss` so the owner can
// persist the choice; remembering it across pages is the caller's job.
@jsx.component
let make = (
  ~variant: Contracts.AnnouncementBar.variant=#neutral,
  ~message: string,
  ~actionLabel: string="",
  ~actionHref: string="#",
  ~onDismiss: option<unit => unit>=?,
) => {
  let open_ = Signal.make(true)
  let dismiss = _ => {
    Signal.set(open_, false)
    switch onDismiss {
    | Some(fn) => fn()
    | None => ()
    }
  }
  let (surface, iconName, iconCls) = switch variant {
  | #neutral => ("border-b border-border bg-surface text-ink", "info", "text-muted")
  | #accent => ("bg-accent text-accent-contrast", "zap", "text-accent-contrast")
  | #warning => ("border-b border-status-warning bg-surface text-ink", "alert-triangle", "text-status-warning")
  }
  let linkCls = switch variant {
  | #accent => "font-medium underline underline-offset-2 hover:opacity-80"
  | #neutral | #warning => "font-medium text-ink underline underline-offset-2 hover:text-muted"
  }
  <View.Show when_={Prop.signal(open_)}>
    <div class={"flex w-full flex-wrap items-center justify-center gap-x-3 gap-y-1 px-4 py-2 text-sm " ++ surface}>
      <span class={"shrink-0 " ++ iconCls}> <Icon name=iconName size=#sm /> </span>
      <p> <View.Text> message </View.Text> </p>
      {actionLabel == ""
        ? View.null()
        : <a href=actionHref class=linkCls> <View.Text> actionLabel </View.Text> </a>}
      <span class="ms-auto">
        <IconButton label="Dismiss announcement" variant=#ghost onClick=dismiss>
          <Icon name="x" size=#sm />
        </IconButton>
      </span>
    </div>
  </View.Show>
}
