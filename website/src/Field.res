// Field — pairs a label with a control (and optional hint). Reused by form,
// dialog, and the input/textarea examples.
@jsx.component
let make = (~label: string, ~for_: string, ~hint: string="", ~children: View.node) =>
  <div class="space-y-1.5">
    <label class={Ui.label} for_> <View.Text> {label} </View.Text> </label>
    {children}
    {hint == ""
      ? View.null()
      : <p class="text-xs text-neutral-500"> <View.Text> {hint} </View.Text> </p>}
  </div>
