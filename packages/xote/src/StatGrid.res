// Stat Grid — the metric-summary band a dashboard opens with. Each entry is
// (label, value, delta, trend); `trend` reuses the stat contract's enum
// (Contracts.Stat.trend) so direction values can't drift. `loading` renders
// skeleton tiles in the same grid, so the layout is reserved and nothing
// shifts when values arrive (the `stat-grid` spec's loading state).
@jsx.component
let make = (
  ~heading: string="",
  ~stats: array<(string, string, string, Contracts.Stat.trend)>,
  ~loading: bool=false,
) =>
  <section class="w-full">
    {heading == ""
      ? View.null()
      : <h2 class="mb-3 text-sm font-medium text-muted"> <View.Text> heading </View.Text> </h2>}
    <ul class="grid w-full grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
      {loading
        ? <View.For
            each={Prop.static(stats)}
            render={_ =>
              <li class={Ui.card ++ " p-4"} ariaHidden="true">
                <Skeleton shape=#text extraClass="w-20" />
                <Skeleton shape=#text extraClass="mt-3 h-7 w-28" />
                <Skeleton shape=#text extraClass="mt-3 w-16" />
              </li>}
          />
        : <View.For
            each={Prop.static(stats)}
            render={stat => {
              let (label, value, delta, trend) = stat
              // Direction is conveyed by icon + text, not color alone.
              let (trendIcon, trendCls) = switch trend {
              | #up => ("arrow-up", "text-status-success")
              | #down => ("arrow-down", "text-status-danger")
              | #flat => ("minus", "text-muted")
              }
              <li class={Ui.card ++ " p-4"}>
                <p class="text-sm text-muted"> <View.Text> label </View.Text> </p>
                <p class="mt-1 text-2xl font-semibold tracking-tight text-ink">
                  <View.Text> value </View.Text>
                </p>
                {delta == ""
                  ? View.null()
                  : <p class={"mt-1 flex items-center gap-1 text-xs font-medium " ++ trendCls}>
                      <Icon name=trendIcon size=#xs />
                      <View.Text> delta </View.Text>
                    </p>}
              </li>
            }}
          />}
    </ul>
  </section>
