// Avatar — a person/entity glyph with an initials fallback. Reused by hover-card
// and others.
@jsx.component
let make = (~initials: string, ~size: string="size-10 text-sm") =>
  <span
    class={"inline-flex items-center justify-center overflow-hidden rounded-full bg-neutral-200 font-medium text-neutral-700 ring-2 ring-white " ++
    size}>
    <View.Text> {initials} </View.Text>
  </span>
