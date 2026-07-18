// Breadcrumb — a hierarchy trail. Each item is a (label, href) pair; the last
// item (or any with an empty href) renders as the current page. Implements the
// `breadcrumb` spec.
@jsx.component
let make = (~items: array<(string, string)>) => {
  let last = Array.length(items) - 1
  let indexed = items->Array.mapWithIndex((item, i) => (item, i))
  <nav class="flex items-center gap-2 text-sm">
    <View.For
      each={Prop.static(indexed)}
      render={pair => {
        let ((label, href), i) = pair
        let isLast = i == last
        <span class="flex items-center gap-2">
          {isLast || href == ""
            ? <span class="font-medium text-neutral-900"> <View.Text> label </View.Text> </span>
            : <a class="text-neutral-500 hover:text-neutral-900" href={href}> <View.Text> label </View.Text> </a>}
          {isLast ? View.null() : <span class="text-neutral-300"> <View.Text> "/" </View.Text> </span>}
        </span>
      }}
    />
  </nav>
}
