// Button — the reusable action control. Reused directly (`<Button ...>`) by the
// card, dialog, form, navbar, and other specs — and by the site's own
// chrome. Its `variant`/`size` prop types come from the spec's `## API`
// contract (see Contracts.res, generated), so the compiler enforces that this
// implementation stays in sync with the spec's allowed values.
@jsx.component
let make = (
  ~variant: Contracts.Button.variant=#primary,
  ~size: Contracts.Button.size=#md,
  ~type_: Contracts.Button.type_=#button,
  ~disabled: bool=false,
  ~loading: bool=false,
  ~onClick: option<Dom.event => unit>=?,
  ~extraClass: string="",
  ~children: View.node,
) => {
  let typeStr = switch type_ {
  | #button => "button"
  | #submit => "submit"
  | #reset => "reset"
  }
  let sizeCls = switch size {
  | #sm => Ui.btnSm
  | #md => Ui.btnMd
  | #lg => Ui.btnLg
  }
  let colors = switch variant {
  | #primary => Ui.btnPrimaryColors
  | #secondary => Ui.btnSecondaryColors
  | #ghost => Ui.btnGhostColors
  | #destructive => Ui.btnDestructiveColors
  }
  // Dark-surface variants need an on-accent spinner; light ones use ink.
  let spinnerTone = switch variant {
  | #primary | #destructive => #onAccent
  | #secondary | #ghost => #ink
  }
  <button
    type_={typeStr}
    disabled={disabled || loading}
    class={Ui.btnCore ++
    " " ++
    sizeCls ++
    " " ++
    colors ++ (extraClass == "" ? "" : " " ++ extraClass)}
    ?onClick>
    <View.Show when_={Prop.static(loading)}>
      <Spinner size="size-4" tone=spinnerTone />
    </View.Show>
    {children}
  </button>
}
