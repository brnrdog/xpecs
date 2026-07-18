// ButtonGroup — joins related buttons into a single visual unit; the divider
// between children is drawn by the group. Implements the `button-group` spec.
@jsx.component
let make = (~extraClass: string="", ~children: View.node) =>
  <div
    class={"inline-flex divide-x divide-neutral-300 overflow-hidden rounded-md border border-neutral-300" ++ (
      extraClass == "" ? "" : " " ++ extraClass
    )}>
    {children}
  </div>
