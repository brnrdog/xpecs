// EmptyState — a placeholder shown when there's no content yet, guiding the user
// toward a first action (pass the action as children). Implements the
// `empty-state` spec.
@jsx.component
let make = (
  ~icon: string="",
  ~title: string,
  ~description: string="",
  ~extraClass: string="",
  ~children: View.node,
) =>
  <div
    class={"flex flex-col items-center gap-3 rounded-lg border border-dashed border-neutral-300 p-10 text-center" ++ (
      extraClass == "" ? "" : " " ++ extraClass
    )}>
    {icon == ""
      ? View.null()
      : <div class="flex size-12 items-center justify-center rounded-full bg-neutral-100 text-xl text-neutral-400">
          <View.Text> icon </View.Text>
        </div>}
    <div>
      <p class="font-medium text-neutral-800"> <View.Text> title </View.Text> </p>
      {description == ""
        ? View.null()
        : <p class="mt-1 text-sm text-neutral-500"> <View.Text> description </View.Text> </p>}
    </div>
    {children}
  </div>
