// Input — a single-line text field. Reused by form, field, dialog, and filters.
@jsx.component
let make = (
  ~type_: string="text",
  ~id: option<string>=?,
  ~placeholder: string="",
  ~value: option<string>=?,
  ~required: bool=false,
  ~onInput: option<Dom.event => unit>=?,
  ~extraClass: string="",
) =>
  <input
    type_
    ?id
    placeholder
    required
    ?value
    ?onInput
    class={Ui.inputBase ++ (extraClass == "" ? "" : " " ++ extraClass)}
  />
