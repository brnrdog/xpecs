// Alert — an inline message drawing attention to contextual information. The
// `variant` type comes from the archetype's `## API` contract (Contracts.res),
// so the compiler enforces the spec's allowed severities. Monochrome baseline:
// severity is conveyed by fill weight, not hue.
@jsx.component
let make = (
  ~variant: Contracts.Alert.variant=#info,
  ~title: string,
  ~description: string,
  ~icon: string="",
) => {
  let tone = switch variant {
  | #info => "border-neutral-200 bg-neutral-50 text-neutral-700"
  | #success => "border-neutral-300 bg-neutral-100 text-neutral-800"
  | #warning => "border-neutral-400 bg-neutral-100 text-neutral-900"
  | #danger => "border-neutral-900 bg-neutral-900 text-neutral-100"
  }
  let titleColor = switch variant {
  | #danger => "text-white"
  | _ => "text-neutral-900"
  }
  <div role="alert" class={"flex gap-3 rounded-lg border p-4 text-sm " ++ tone}>
    <View.Show when_={Prop.static(icon != "")}>
      <span class="font-semibold"> <View.Text> icon </View.Text> </span>
    </View.Show>
    <div>
      <p class={"font-medium " ++ titleColor}> <View.Text> title </View.Text> </p>
      <p class="opacity-80"> <View.Text> description </View.Text> </p>
    </div>
  </div>
}
