// Page Header — opens an application view: an optional breadcrumb trail, the
// view's single h1 with a line of context, and the view's actions (passed as
// children, e.g. <Button/>s), aligned opposite the title. Implements the
// `page-header` spec: the actions cluster wraps under the title on narrow
// containers and long titles truncate rather than pushing the actions away.
// A breadcrumb entry with an empty href renders as the current page.
@jsx.component
let make = (
  ~title: string,
  ~description: string="",
  ~breadcrumb: array<(string, string)>=[],
  ~children: View.node,
) =>
  <header
    class="flex w-full flex-wrap items-start justify-between gap-x-6 gap-y-4 border-b border-border pb-5">
    <div class="min-w-0">
      {breadcrumb->Array.length == 0
        ? View.null()
        : <nav ariaLabel="Breadcrumb" class="mb-1.5">
            <ul class="flex items-center gap-1.5 text-xs text-muted">
              <View.For
                each={Prop.static(breadcrumb)}
                render={crumb => {
                  let (label, href) = crumb
                  <li class="flex items-center gap-1.5">
                    {href == ""
                      ? <span class="font-medium text-ink"> <View.Text> label </View.Text> </span>
                      : <span class="flex items-center gap-1.5">
                          <a href class="transition-colors hover:text-ink">
                            <View.Text> label </View.Text>
                          </a>
                          <span class="text-neutral-300"> <Icon name="chevron-right" size=#xs /> </span>
                        </span>}
                  </li>
                }}
              />
            </ul>
          </nav>}
      <h1 class="truncate text-2xl font-semibold tracking-tight text-ink">
        <View.Text> title </View.Text>
      </h1>
      {description == ""
        ? View.null()
        : <p class="mt-1 text-sm text-muted"> <View.Text> description </View.Text> </p>}
    </div>
    <div class="flex shrink-0 items-center gap-2"> {children} </div>
  </header>
