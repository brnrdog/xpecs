// Spinner — an indeterminate loading indicator. Reused inside Button (loading)
// and elsewhere.
@jsx.component
let make = (~size: string="size-4", ~tone: [#ink | #onAccent]=#ink) => {
  let colors = switch tone {
  | #ink => "border-neutral-300 border-t-neutral-900"
  | #onAccent => "border-white/40 border-t-white"
  }
  <span class={"inline-block animate-spin rounded-full border-2 " ++ colors ++ " " ++ size} />
}
