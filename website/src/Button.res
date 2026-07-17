// Button — the reusable action control. Reused directly (`<Button ...>`) by the
// card, dialog, form, navbar, and other archetypes.
@jsx.component
let make = (
  ~variant: [#primary | #secondary | #ghost | #destructive]=#primary,
  ~type_: string="button",
  ~disabled: bool=false,
  ~onClick: option<Dom.event => unit>=?,
  ~extraClass: string="",
  ~children: View.node,
) => {
  let base = switch variant {
  | #primary => Ui.btnPrimary
  | #secondary => Ui.btnSecondary
  | #ghost => Ui.btnGhost
  | #destructive => Ui.btnDestructive
  }
  <button type_ disabled class={base ++ (extraClass == "" ? "" : " " ++ extraClass)} ?onClick>
    {children}
  </button>
}
