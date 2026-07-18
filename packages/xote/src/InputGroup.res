// InputGroup — an input combined with adjacent add-ons (prefix, suffix, button)
// that read as one composite control. Implements the `input-group` spec.
@jsx.component
let make = (~extraClass: string="", ~children: View.node) =>
  <div class={"flex" ++ (extraClass == "" ? "" : " " ++ extraClass)}> {children} </div>
