// Card — a self-contained surface that groups related content and actions.
// Implements the `card` spec.
@jsx.component
let make = (~extraClass: string="", ~children: View.node) =>
  <div class={Ui.card ++ (extraClass == "" ? "" : " " ++ extraClass)}> {children} </div>
