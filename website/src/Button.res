// Button — the reusable action control. Reused directly (`<Button ...>`) by the
// card, dialog, form, navbar, and other archetypes — and by the site's own chrome.
@jsx.component
let make = (
  ~variant: [#primary | #secondary | #ghost | #destructive]=#primary,
  ~size: [#sm | #md]=#md,
  ~type_: string="button",
  ~disabled: bool=false,
  ~onClick: option<Dom.event => unit>=?,
  ~extraClass: string="",
  ~children: View.node,
) => {
  let sizeCls = switch size {
  | #sm => Ui.btnSm
  | #md => Ui.btnMd
  }
  let colors = switch variant {
  | #primary => Ui.btnPrimaryColors
  | #secondary => Ui.btnSecondaryColors
  | #ghost => Ui.btnGhostColors
  | #destructive => Ui.btnDestructiveColors
  }
  <button
    type_
    disabled
    class={Ui.btnCore ++
    " " ++
    sizeCls ++
    " " ++
    colors ++ (extraClass == "" ? "" : " " ++ extraClass)}
    ?onClick>
    {children}
  </button>
}
