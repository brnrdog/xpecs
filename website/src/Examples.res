// Live Xote implementations of the archetypes. Each example is a small,
// self-contained component. `get` maps an archetype id to its example node
// (returning None when only the written spec exists yet).

module Button = {
  @jsx.component
  let make = () => {
    let loading = Signal.make(false)
    <div class="flex flex-wrap items-center gap-3">
      <Kit.Button variant=#primary> <View.Text> "Primary" </View.Text> </Kit.Button>
      <Kit.Button variant=#secondary> <View.Text> "Secondary" </View.Text> </Kit.Button>
      <Kit.Button variant=#ghost> <View.Text> "Ghost" </View.Text> </Kit.Button>
      <Kit.Button variant=#destructive> <View.Text> "Delete" </View.Text> </Kit.Button>
      <Kit.Button variant=#secondary disabled=true> <View.Text> "Disabled" </View.Text> </Kit.Button>
      <Kit.Button
        variant=#primary
        onClick={_ => {
          Signal.set(loading, true)
          Ui.setTimeout(() => Signal.set(loading, false), 1200)
        }}>
        <View.Show when_={Prop.signal(loading)} fallback={<View.Text> "Save" </View.Text>}>
          <Kit.Spinner tone=#onAccent />
          <View.Text> "Saving…" </View.Text>
        </View.Show>
      </Kit.Button>
    </div>
  }
}

module Input = {
  @jsx.component
  let make = () => {
    let value = Signal.make("")
    <div class="max-w-sm">
      <Kit.Field label="Email" for_="ex-email">
        <Kit.Input
          id="ex-email"
          type_="email"
          placeholder="you@example.com"
          onInput={e => Signal.set(value, Ui.inputValue(e))}
        />
      </Kit.Field>
      <p class="mt-2 text-xs text-neutral-500">
        <View.Text> "You typed: " </View.Text>
        <View.Text> {value} </View.Text>
      </p>
    </div>
  }
}

module Textarea = {
  @jsx.component
  let make = () => {
    let value = Signal.make("")
    let count = Computed.make(() => Signal.get(value)->String.length)
    <div class="max-w-sm">
      <Kit.Field label="Message" for_="ex-ta">
        <textarea
          id="ex-ta"
          rows=4
          class={Ui.inputBase ++ " resize-y"}
          placeholder="Write something…"
          onInput={e => Signal.set(value, Ui.inputValue(e))}
        />
      </Kit.Field>
      <p class="mt-2 text-right text-xs text-neutral-500">
        <View.Int> {count} </View.Int>
        <View.Text> " / 280" </View.Text>
      </p>
    </div>
  }
}

module Badge = {
  @jsx.component
  let make = () => {
    <div class="flex flex-wrap items-center gap-2">
      <Kit.Badge variant=#solid> <View.Text> "Default" </View.Text> </Kit.Badge>
      <Kit.Badge variant=#soft> <View.Text> "Secondary" </View.Text> </Kit.Badge>
      <Kit.Badge variant=#outline> <View.Text> "Outline" </View.Text> </Kit.Badge>
      <Kit.Badge variant=#soft>
        <span class="mr-1 size-1.5 rounded-full bg-neutral-500" />
        <View.Text> "Idle" </View.Text>
      </Kit.Badge>
      <Kit.Badge variant=#solid> <View.Text> "99+" </View.Text> </Kit.Badge>
    </div>
  }
}

module Avatar = {
  @jsx.component
  let make = () => {
    <div class="flex items-center gap-4">
      <Kit.Avatar initials="BG" size="size-10 text-sm" />
      <Kit.Avatar initials="AK" size="size-12" />
      <div class="flex -space-x-2">
        <Kit.Avatar initials="JD" size="size-9 text-xs" />
        <Kit.Avatar initials="MP" size="size-9 text-xs" />
        <Kit.Avatar initials="RM" size="size-9 text-xs" />
        <span
          class="inline-flex size-9 items-center justify-center rounded-full bg-neutral-900 text-xs font-medium text-white ring-2 ring-white">
          <View.Text> "+3" </View.Text>
        </span>
      </div>
    </div>
  }
}

module Checkbox = {
  @jsx.component
  let make = () => {
    let on = Signal.make(true)
    <label class="flex items-start gap-3">
      <input
        type_="checkbox"
        checked={Prop.signal(on)}
        class="mt-0.5 size-4 accent-neutral-900"
        onChange={e => Signal.set(on, Ui.checked(e))}
      />
      <span>
        <span class="block text-sm font-medium text-neutral-800"> <View.Text> "Subscribe" </View.Text> </span>
        <span class="block text-xs text-neutral-500"> <View.Text> "Get product updates by email." </View.Text> </span>
      </span>
    </label>
  }
}

module Switch = {
  @jsx.component
  let make = () => {
    let on = Signal.make(false)
    <Kit.Switch on label="Airplane mode" />
  }
}

module Slider = {
  @jsx.component
  let make = () => {
    let value = Signal.make(40)
    <div class="max-w-sm space-y-2">
      <div class="flex justify-between text-sm text-neutral-800">
        <span> <View.Text> "Volume" </View.Text> </span>
        <span class="tabular-nums"> <View.Int> {value} </View.Int> <View.Text> "%" </View.Text> </span>
      </div>
      <input
        type_="range"
        min="0"
        max="100"
        value={Prop.signal(Computed.make(() => Signal.get(value)->Int.toString))}
        class="w-full accent-neutral-900"
        onInput={e => Signal.set(value, Ui.inputValue(e)->Int.fromString->Option.getOr(0))}
      />
    </div>
  }
}

module Progress = {
  @jsx.component
  let make = () => {
    let value = Signal.make(30)
    let bar = Computed.make(() => "height:100%;width:" ++ Signal.get(value)->Int.toString ++ "%")
    <div class="max-w-sm space-y-3">
      <div class="h-2 w-full overflow-hidden rounded-full bg-neutral-200" role="progressbar">
        <div class="rounded-full bg-neutral-900 transition-all" style={Prop.signal(bar)} />
      </div>
      <div class="flex gap-2">
        <Kit.Button variant=#secondary onClick={_ => Signal.update(value, v => v > 10 ? v - 10 : 0)}>
          <View.Text> "−10" </View.Text>
        </Kit.Button>
        <Kit.Button variant=#secondary onClick={_ => Signal.update(value, v => v < 90 ? v + 10 : 100)}>
          <View.Text> "+10" </View.Text>
        </Kit.Button>
      </div>
    </div>
  }
}

module Spinner = {
  @jsx.component
  let make = () =>
    <div class="flex items-center gap-4 text-neutral-700">
      <Kit.Spinner size="size-4" />
      <Kit.Spinner size="size-6" />
      <Kit.Spinner size="size-8" />
      <span class="text-sm text-neutral-500"> <View.Text> "Loading…" </View.Text> </span>
    </div>
}

module Skeleton = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm space-y-3">
      <div class="flex items-center gap-3">
        <div class="size-10 animate-pulse rounded-full bg-neutral-200" />
        <div class="flex-1 space-y-2">
          <div class="h-3 w-1/2 animate-pulse rounded bg-neutral-200" />
          <div class="h-3 w-1/3 animate-pulse rounded bg-neutral-200" />
        </div>
      </div>
      <div class="h-3 w-full animate-pulse rounded bg-neutral-200" />
      <div class="h-3 w-5/6 animate-pulse rounded bg-neutral-200" />
    </div>
}

module Separator = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm text-sm text-neutral-700">
      <p> <View.Text> "Above the line" </View.Text> </p>
      <Kit.Separator extraClass="my-3" />
      <div class="flex items-center gap-3">
        <span> <View.Text> "Home" </View.Text> </span>
        <Kit.Separator orientation=#vertical />
        <span> <View.Text> "Docs" </View.Text> </span>
        <Kit.Separator orientation=#vertical />
        <span> <View.Text> "About" </View.Text> </span>
      </div>
    </div>
}

module Label = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm space-y-1">
      <label class={Ui.label} for_="ex-label">
        <View.Text> "Full name " </View.Text>
        <span class="text-neutral-400"> <View.Text> "(required)" </View.Text> </span>
      </label>
      <Kit.Input id="ex-label" placeholder="Ada Lovelace" />
    </div>
}

module Kbd = {
  @jsx.component
  let make = () => {
    <div class="flex items-center gap-2 text-sm text-neutral-700">
      <span> <View.Text> "Open search" </View.Text> </span>
      <Kit.Kbd> <View.Text> "⌘" </View.Text> </Kit.Kbd>
      <Kit.Kbd> <View.Text> "K" </View.Text> </Kit.Kbd>
    </div>
  }
}

module Typography = {
  @jsx.component
  let make = () =>
    <div class="max-w-prose space-y-3">
      <h1 class="text-3xl font-bold tracking-tight text-neutral-900"> <View.Text> "Heading one" </View.Text> </h1>
      <h2 class="text-xl font-semibold text-neutral-900"> <View.Text> "Heading two" </View.Text> </h2>
      <p class="text-sm leading-relaxed text-neutral-700">
        <View.Text> "Body copy sets the reading rhythm. Inline elements like " </View.Text>
        <strong class="font-semibold text-neutral-900"> <View.Text> "strong" </View.Text> </strong>
        <View.Text> " and " </View.Text>
        <code class="rounded bg-neutral-100 px-1 py-0.5 font-mono text-xs"> <View.Text> "code" </View.Text> </code>
        <View.Text> " carry meaning through markup, not styling alone." </View.Text>
      </p>
      <blockquote class="border-l-2 border-neutral-300 pl-4 text-sm italic text-neutral-600">
        <View.Text> "Type is the connective tissue of the interface." </View.Text>
      </blockquote>
    </div>
}

module RadioGroup = {
  @jsx.component
  let make = () => {
    let value = Signal.make("express")
    let opts = [
      ("standard", "Standard", "3–5 business days"),
      ("express", "Express", "1–2 business days"),
      ("overnight", "Overnight", "Next business day"),
    ]
    <fieldset class="max-w-sm space-y-2">
      <legend class="mb-1 text-sm font-medium text-neutral-800"> <View.Text> "Shipping speed" </View.Text> </legend>
      <View.For
        each={Prop.static(opts)}
        render={item => {
          let (id, title, desc) = item
          let rowCls = Computed.make(() =>
            "flex cursor-pointer items-start gap-3 rounded-md border p-3 transition-colors " ++ (
              Signal.get(value) == id
                ? "border-neutral-900 bg-neutral-50"
                : "border-neutral-200 hover:border-neutral-300"
            )
          )
          let ring = Computed.make(() =>
            "mt-0.5 flex size-4 items-center justify-center rounded-full border " ++ (
              Signal.get(value) == id ? "border-neutral-900" : "border-neutral-300"
            )
          )
          let dot = Computed.make(() =>
            "size-2 rounded-full " ++ (Signal.get(value) == id ? "bg-neutral-900" : "bg-transparent")
          )
          <label class={Prop.signal(rowCls)} onClick={_ => Signal.set(value, id)}>
            <span class={Prop.signal(ring)}> <span class={Prop.signal(dot)} /> </span>
            <span>
              <span class="block text-sm font-medium text-neutral-800"> <View.Text> {title} </View.Text> </span>
              <span class="block text-xs text-neutral-500"> <View.Text> {desc} </View.Text> </span>
            </span>
          </label>
        }}
      />
    </fieldset>
  }
}

module Toggle = {
  @jsx.component
  let make = () => {
    let on = Signal.make(true)
    let cls = Computed.make(() =>
      "inline-flex size-10 items-center justify-center rounded-md text-sm font-semibold transition-colors " ++ (
        Signal.get(on)
          ? "bg-neutral-900 text-white"
          : "border border-neutral-300 bg-white text-neutral-700 hover:bg-neutral-100"
      )
    )
    <button class={Prop.signal(cls)} onClick={_ => Signal.update(on, v => !v)}>
      <span class="italic"> <View.Text> "B" </View.Text> </span>
    </button>
  }
}

module ToggleGroup = {
  @jsx.component
  let make = () => {
    let value = Signal.make("center")
    let opts = [("left", "Left"), ("center", "Center"), ("right", "Right")]
    <div class="inline-flex overflow-hidden rounded-md border border-neutral-300">
      <View.For
        each={Prop.static(opts)}
        render={item => {
          let (id, label) = item
          let cls = Computed.make(() =>
            "border-l border-neutral-300 px-4 py-2 text-sm transition-colors first:border-l-0 " ++ (
              Signal.get(value) == id
                ? "bg-neutral-900 text-white"
                : "bg-white text-neutral-700 hover:bg-neutral-100"
            )
          )
          <button class={Prop.signal(cls)} onClick={_ => Signal.set(value, id)}>
            <View.Text> {label} </View.Text>
          </button>
        }}
      />
    </div>
  }
}

module AspectRatio = {
  @jsx.component
  let make = () => {
    let box = "flex items-center justify-center overflow-hidden rounded-lg bg-neutral-200 text-sm font-medium text-neutral-500"
    <div class="flex flex-wrap items-start gap-4">
      <div class="w-56">
        <div class={box ++ " aspect-video"}> <View.Text> "16 : 9" </View.Text> </div>
      </div>
      <div class="w-32">
        <div class={box ++ " aspect-square"}> <View.Text> "1 : 1" </View.Text> </div>
      </div>
    </div>
  }
}

module ScrollArea = {
  @jsx.component
  let make = () => {
    let rows = Array.fromInitializer(~length=24, i => "Row " ++ Int.toString(i + 1))
    <div class="h-44 w-64 overflow-y-auto rounded-md border border-neutral-200">
      <ul class="divide-y divide-neutral-100 text-sm">
        <View.For
          each={Prop.static(rows)}
          render={r => <li class="px-3 py-2 text-neutral-700"> <View.Text> {r} </View.Text> </li>}
        />
      </ul>
    </div>
  }
}

module InputOtp = {
  @jsx.component
  let make = () => {
    let code = Signal.make("")
    let slots = Array.fromInitializer(~length=6, i => i)
    <label class="relative inline-flex gap-2">
      <input
        class="absolute inset-0 z-10 cursor-pointer opacity-0"
        type_="text"
        maxLength=6
        onInput={e => {
          let digits =
            Ui.inputValue(e)->String.replaceRegExp(%re("/[^0-9]/g"), "")->String.slice(~start=0, ~end=6)
          Signal.set(code, digits)
        }}
      />
      <View.For
        each={Prop.static(slots)}
        render={i => {
          let cls = Computed.make(() => {
            let len = Signal.get(code)->String.length
            "flex size-11 items-center justify-center rounded-md border text-lg font-semibold text-neutral-900 " ++ (
              len == i ? "border-neutral-900 ring-1 ring-neutral-900" : "border-neutral-300"
            )
          })
          let ch = Computed.make(() => Signal.get(code)->String.charAt(i))
          <span class={Prop.signal(cls)}> <View.Text> {ch} </View.Text> </span>
        }}
      />
    </label>
  }
}

module Card = {
  @jsx.component
  let make = () =>
    <Kit.Card extraClass="w-80 overflow-hidden">
      <div class="flex aspect-video items-center justify-center bg-neutral-100 text-neutral-400">
        <View.Text> "cover" </View.Text>
      </div>
      <div class="space-y-3 p-5">
        <div class="flex items-center justify-between">
          <h3 class="font-semibold text-neutral-900"> <View.Text> "Analytics plan" </View.Text> </h3>
          <Kit.Badge variant=#solid> <View.Text> "Pro" </View.Text> </Kit.Badge>
        </div>
        <p class="text-sm text-neutral-500">
          <View.Text> "Usage insights, exports, and unlimited dashboards for growing teams." </View.Text>
        </p>
        <div class="flex gap-2 pt-1">
          <Kit.Button variant=#primary> <View.Text> "Upgrade" </View.Text> </Kit.Button>
          <Kit.Button variant=#ghost> <View.Text> "Details" </View.Text> </Kit.Button>
        </div>
      </div>
    </Kit.Card>
}

module Alert = {
  @jsx.component
  let make = () => {
    let row = "flex gap-3 rounded-lg border p-4 text-sm"
    <div class="max-w-md space-y-3">
      <div class={row ++ " border-neutral-200 bg-neutral-50 text-neutral-700"}>
        <span class="font-semibold"> <View.Text> "i" </View.Text> </span>
        <div>
          <p class="font-medium text-neutral-900"> <View.Text> "Heads up" </View.Text> </p>
          <p class="text-neutral-600"> <View.Text> "Your trial ends in 3 days." </View.Text> </p>
        </div>
      </div>
      <div class={row ++ " border-neutral-900 bg-neutral-900 text-neutral-100"}>
        <span class="font-semibold"> <View.Text> "!" </View.Text> </span>
        <div>
          <p class="font-medium text-white"> <View.Text> "Payment failed" </View.Text> </p>
          <p class="text-neutral-300"> <View.Text> "Update your card to keep your subscription active." </View.Text> </p>
        </div>
      </div>
    </div>
  }
}

module Tabs = {
  @jsx.component
  let make = () => {
    let active = Signal.make(0)
    let tabs = [(0, "Account"), (1, "Password"), (2, "Team")]
    let content = Computed.make(() =>
      switch Signal.get(active) {
      | 0 => "Manage your account details and profile information."
      | 1 => "Change your password and configure two-factor authentication."
      | _ => "Invite teammates and manage their roles and access."
      }
    )
    <div class="w-96">
      <div class="flex gap-1 border-b border-neutral-200">
        <View.For
          each={Prop.static(tabs)}
          render={item => {
            let (idx, label) = item
            let cls = Computed.make(() =>
              "-mb-px border-b-2 px-4 py-2 text-sm font-medium transition-colors " ++ (
                Signal.get(active) == idx
                  ? "border-neutral-900 text-neutral-900"
                  : "border-transparent text-neutral-500 hover:text-neutral-800"
              )
            )
            <button class={Prop.signal(cls)} onClick={_ => Signal.set(active, idx)}>
              <View.Text> {label} </View.Text>
            </button>
          }}
        />
      </div>
      <p class="p-4 text-sm text-neutral-600"> <View.Text> {content} </View.Text> </p>
    </div>
  }
}

module Accordion = {
  @jsx.component
  let make = () => {
    let openId = Signal.make(0)
    let items = [
      (0, "What is an archetype?", "A technology-agnostic definition of a UI pattern, described in words."),
      (1, "Is it tied to a framework?", "No. Each archetype maps onto any stack — this site happens to use Xote."),
      (2, "Can I contribute?", "Yes. Copy the template, fill every section, and open a pull request."),
    ]
    <div class="w-96 divide-y divide-neutral-200 rounded-lg border border-neutral-200">
      <View.For
        each={Prop.static(items)}
        render={item => {
          let (idx, q, aText) = item
          let isOpen = Computed.make(() => Signal.get(openId) == idx)
          let mark = Computed.make(() => Signal.get(openId) == idx ? "−" : "+")
          <div>
            <button
              class="flex w-full items-center justify-between px-4 py-3 text-left text-sm font-medium text-neutral-800 hover:bg-neutral-50"
              onClick={_ => Signal.update(openId, cur => cur == idx ? -1 : idx)}>
              <View.Text> {q} </View.Text>
              <span class="text-neutral-400"> <View.Text> {mark} </View.Text> </span>
            </button>
            <View.Show when_={Prop.signal(isOpen)}>
              <p class="px-4 pb-3 text-sm text-neutral-500"> <View.Text> {aText} </View.Text> </p>
            </View.Show>
          </div>
        }}
      />
    </div>
  }
}

module Collapsible = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    let mark = Computed.make(() => Signal.get(open_) ? "Hide details" : "Show details")
    <div class="w-80 space-y-2">
      <Kit.Button
        variant=#secondary
        extraClass="w-full justify-between"
        onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> {mark} </View.Text>
        <span class="text-neutral-400"> <View.Text> "⌄" </View.Text> </span>
      </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="rounded-md border border-neutral-200 p-3 text-sm text-neutral-600">
          <View.Text> "Secondary content revealed on demand, pushing the layout below it." </View.Text>
        </div>
      </View.Show>
    </div>
  }
}

module Dialog = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full max-w-lg items-center justify-center">
      <Kit.Button variant=#primary onClick={_ => Signal.set(open_, true)}>
        <View.Text> "Edit profile" </View.Text>
      </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 flex items-center justify-center">
          <div class="absolute inset-0 bg-neutral-900/40" onClick={_ => Signal.set(open_, false)} />
          <div class="relative z-20 w-80 rounded-lg border border-neutral-200 bg-white p-5 shadow-2xl">
            <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Edit profile" </View.Text> </h3>
            <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Make changes and save when you're done." </View.Text> </p>
            <div class="mt-4">
              <Kit.Field label="Name" for_="dlg-name">
                <Kit.Input id="dlg-name" value="Ada Lovelace" />
              </Kit.Field>
            </div>
            <div class="mt-5 flex justify-end gap-2">
              <Kit.Button variant=#secondary onClick={_ => Signal.set(open_, false)}> <View.Text> "Cancel" </View.Text> </Kit.Button>
              <Kit.Button variant=#primary onClick={_ => Signal.set(open_, false)}> <View.Text> "Save" </View.Text> </Kit.Button>
            </div>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module AlertDialog = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full max-w-lg items-center justify-center">
      <Kit.Button variant=#destructive onClick={_ => Signal.set(open_, true)}>
        <View.Text> "Delete account" </View.Text>
      </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 flex items-center justify-center">
          <div class="absolute inset-0 bg-neutral-900/40" />
          <div class="relative z-20 w-80 rounded-lg border border-neutral-200 bg-white p-5 shadow-2xl">
            <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Are you absolutely sure?" </View.Text> </h3>
            <p class="mt-1 text-sm text-neutral-500"> <View.Text> "This permanently deletes your account and all data. This cannot be undone." </View.Text> </p>
            <div class="mt-5 flex justify-end gap-2">
              <Kit.Button variant=#secondary onClick={_ => Signal.set(open_, false)}> <View.Text> "Cancel" </View.Text> </Kit.Button>
              <Kit.Button variant=#destructive onClick={_ => Signal.set(open_, false)}> <View.Text> "Delete" </View.Text> </Kit.Button>
            </div>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Tooltip = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="flex h-24 items-center justify-center">
      <span
        class="relative inline-block"
        onMouseEnter={_ => Signal.set(open_, true)}
        onMouseLeave={_ => Signal.set(open_, false)}>
        <Kit.Button variant=#secondary> <View.Text> "Hover me" </View.Text> </Kit.Button>
        <View.Show when_={Prop.signal(open_)}>
          <span class="absolute -top-9 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-md bg-neutral-900 px-2 py-1 text-xs text-white">
            <View.Text> "Add to library" </View.Text>
          </span>
        </View.Show>
      </span>
    </div>
  }
}

module Breadcrumb = {
  @jsx.component
  let make = () => {
    let sep = <span class="text-neutral-300"> <View.Text> "/" </View.Text> </span>
    <nav class="flex items-center gap-2 text-sm">
      <a class="text-neutral-500 hover:text-neutral-900" href="#"> <View.Text> "Home" </View.Text> </a>
      {sep}
      <a class="text-neutral-500 hover:text-neutral-900" href="#"> <View.Text> "Projects" </View.Text> </a>
      {sep}
      <span class="font-medium text-neutral-900"> <View.Text> "Archetypes" </View.Text> </span>
    </nav>
  }
}

module Pagination = {
  @jsx.component
  let make = () => {
    let page = Signal.make(2)
    let pages = [1, 2, 3, 4, 5]
    let navBtn = "inline-flex size-9 items-center justify-center rounded-md text-sm transition-colors"
    <div class="flex items-center gap-1">
      <button
        class={navBtn ++ " border border-neutral-300 text-neutral-700 hover:bg-neutral-100"}
        onClick={_ => Signal.update(page, p => p > 1 ? p - 1 : 1)}>
        <View.Text> "‹" </View.Text>
      </button>
      <View.For
        each={Prop.static(pages)}
        render={p => {
          let cls = Computed.make(() =>
            navBtn ++ (
              Signal.get(page) == p
                ? " bg-neutral-900 text-white"
                : " text-neutral-700 hover:bg-neutral-100"
            )
          )
          <button class={Prop.signal(cls)} onClick={_ => Signal.set(page, p)}>
            <View.Text> {Int.toString(p)} </View.Text>
          </button>
        }}
      />
      <button
        class={navBtn ++ " border border-neutral-300 text-neutral-700 hover:bg-neutral-100"}
        onClick={_ => Signal.update(page, p => p < 5 ? p + 1 : 5)}>
        <View.Text> "›" </View.Text>
      </button>
    </div>
  }
}

module EmptyState = {
  @jsx.component
  let make = () =>
    <div class="flex max-w-sm flex-col items-center gap-3 rounded-lg border border-dashed border-neutral-300 p-10 text-center">
      <div class="flex size-12 items-center justify-center rounded-full bg-neutral-100 text-xl text-neutral-400">
        <View.Text> "☰" </View.Text>
      </div>
      <div>
        <p class="font-medium text-neutral-800"> <View.Text> "No projects yet" </View.Text> </p>
        <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Create your first project to get started." </View.Text> </p>
      </div>
      <Kit.Button variant=#primary> <View.Text> "New project" </View.Text> </Kit.Button>
    </div>
}

module Field = {
  @jsx.component
  let make = () => {
    let value = Signal.make("nope")
    let invalid = Computed.make(() => !(Signal.get(value)->String.includes("@")))
    let cls = Computed.make(() =>
      Ui.inputBase ++ (Signal.get(invalid) ? " border-neutral-900 ring-1 ring-neutral-900" : "")
    )
    <div class="max-w-sm">
      <Kit.Field label="Work email" for_="fld-email">
        <input
          id="fld-email"
          class={Prop.signal(cls)}
          value="nope"
          onInput={e => Signal.set(value, Ui.inputValue(e))}
        />
        <View.Show
          when_={Prop.signal(invalid)}
          fallback={<p class="text-xs text-neutral-500"> <View.Text> "We'll only use this to contact you." </View.Text> </p>}>
          <p class="text-xs font-medium text-neutral-900"> <View.Text> "Enter a valid email address." </View.Text> </p>
        </View.Show>
      </Kit.Field>
    </div>
  }
}

module Form = {
  @jsx.component
  let make = () => {
    let sent = Signal.make(false)
    <form
      class="w-80 space-y-4"
      onSubmit={e => {
        let _: unit = %raw(`(ev) => ev.preventDefault()`)(e)
        Signal.set(sent, true)
      }}>
      <Kit.Field label="Name" for_="frm-name">
        <Kit.Input id="frm-name" placeholder="Ada Lovelace" required=true />
      </Kit.Field>
      <Kit.Field label="Message" for_="frm-msg">
        <textarea id="frm-msg" rows=3 class={Ui.inputBase ++ " resize-none"} placeholder="Say hello…" />
      </Kit.Field>
      <Kit.Button type_="submit" variant=#primary extraClass="w-full"> <View.Text> "Send message" </View.Text> </Kit.Button>
      <View.Show when_={Prop.signal(sent)}>
        <p class="rounded-md bg-neutral-100 px-3 py-2 text-center text-sm text-neutral-700">
          <View.Text> "Thanks — we'll be in touch." </View.Text>
        </p>
      </View.Show>
    </form>
  }
}

module ButtonGroup = {
  @jsx.component
  let make = () =>
    <div class="inline-flex overflow-hidden rounded-md border border-neutral-300">
      <button class="border-r border-neutral-300 bg-white px-3 py-2 text-sm hover:bg-neutral-100"> <View.Text> "Bold" </View.Text> </button>
      <button class="border-r border-neutral-300 bg-white px-3 py-2 text-sm hover:bg-neutral-100"> <View.Text> "Italic" </View.Text> </button>
      <button class="bg-white px-3 py-2 text-sm hover:bg-neutral-100"> <View.Text> "Underline" </View.Text> </button>
    </div>
}

module InputGroup = {
  @jsx.component
  let make = () =>
    <div class="flex max-w-sm">
      <span class="inline-flex items-center rounded-l-md border border-r-0 border-neutral-300 bg-neutral-50 px-3 text-sm text-neutral-500">
        <View.Text> "https://" </View.Text>
      </span>
      <Kit.Input extraClass="rounded-none" placeholder="example.com" />
      <Kit.Button variant=#primary extraClass="rounded-l-none"> <View.Text> "Go" </View.Text> </Kit.Button>
    </div>
}

module Select = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    let value = Signal.make("Medium")
    let opts = ["Small", "Medium", "Large", "Extra large"]
    <div class="relative w-56">
      <button
        class={Ui.inputBase ++ " flex items-center justify-between"}
        onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> {value} </View.Text>
        <span class="text-neutral-400"> <View.Text> "⌄" </View.Text> </span>
      </button>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <ul class="absolute z-20 mt-1 w-full rounded-md border border-neutral-200 bg-white py-1 shadow-lg">
          <View.For
            each={Prop.static(opts)}
            render={o => {
              let mark = Computed.make(() => Signal.get(value) == o ? "✓" : "")
              <li>
                <button
                  class="flex w-full items-center justify-between px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                  onClick={_ => {
                    Signal.set(value, o)
                    Signal.set(open_, false)
                  }}>
                  <View.Text> {o} </View.Text>
                  <span class="text-neutral-900"> <View.Text> {mark} </View.Text> </span>
                </button>
              </li>
            }}
          />
        </ul>
      </View.Show>
    </div>
  }
}

module DropdownMenu = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    let items = ["Profile", "Billing", "Settings", "Sign out"]
    <div class="relative inline-block">
      <Kit.Button variant=#secondary onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> "Options ⌄" </View.Text>
      </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 w-48 rounded-md border border-neutral-200 bg-white py-1 shadow-lg">
          <View.For
            each={Prop.static(items)}
            render={i =>
              <button
                class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                onClick={_ => Signal.set(open_, false)}>
                <View.Text> {i} </View.Text>
              </button>}
          />
        </div>
      </View.Show>
    </div>
  }
}

module ContextMenu = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-40 w-full max-w-md items-center justify-center">
      <div
        class="flex h-28 w-full items-center justify-center rounded-lg border border-dashed border-neutral-300 text-sm text-neutral-500"
        onContextMenu={e => {
          Ui.preventDefault(e)
          Signal.set(open_, true)
        }}>
        <View.Text> "Right-click here" </View.Text>
      </div>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute left-1/2 top-1/2 z-20 w-44 rounded-md border border-neutral-200 bg-white py-1 shadow-lg">
          <View.For
            each={Prop.static(["Cut", "Copy", "Paste", "Delete"])}
            render={i =>
              <button
                class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                onClick={_ => Signal.set(open_, false)}>
                <View.Text> {i} </View.Text>
              </button>}
          />
        </div>
      </View.Show>
    </div>
  }
}

module Popover = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative inline-block">
      <Kit.Button variant=#secondary onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> "Open popover" </View.Text>
      </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-2 w-64 rounded-lg border border-neutral-200 bg-white p-4 shadow-xl">
          <p class="text-sm font-medium text-neutral-900"> <View.Text> "Dimensions" </View.Text> </p>
          <p class="mt-1 text-xs text-neutral-500"> <View.Text> "Set the width and height of the layer." </View.Text> </p>
          <div class="mt-3 space-y-2">
            <Kit.Input placeholder="Width" />
            <Kit.Input placeholder="Height" />
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module HoverCard = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="flex h-40 items-center justify-center">
      <span
        class="relative inline-block"
        onMouseEnter={_ => Signal.set(open_, true)}
        onMouseLeave={_ => Signal.set(open_, false)}>
        <a class="font-medium text-neutral-900 underline decoration-neutral-300 underline-offset-4" href="#">
          <View.Text> "@ada" </View.Text>
        </a>
        <View.Show when_={Prop.signal(open_)}>
          <div class="absolute left-0 top-7 z-20 w-64 rounded-lg border border-neutral-200 bg-white p-4 shadow-xl">
            <div class="flex items-center gap-3">
              <Kit.Avatar initials="AL" />
              <div>
                <p class="text-sm font-semibold text-neutral-900"> <View.Text> "Ada Lovelace" </View.Text> </p>
                <p class="text-xs text-neutral-500"> <View.Text> "First programmer" </View.Text> </p>
              </div>
            </div>
            <p class="mt-3 text-xs text-neutral-600"> <View.Text> "Wrote the first algorithm intended for a machine." </View.Text> </p>
          </div>
        </View.Show>
      </span>
    </div>
  }
}

module Sheet = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full items-center justify-center overflow-hidden rounded-lg">
      <Kit.Button variant=#primary onClick={_ => Signal.set(open_, true)}> <View.Text> "Open sheet" </View.Text> </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 bg-neutral-900/40" onClick={_ => Signal.set(open_, false)} />
        <div class="absolute right-0 top-0 z-20 flex h-full w-72 flex-col border-l border-neutral-200 bg-white p-5 shadow-2xl">
          <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Filters" </View.Text> </h3>
          <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Refine the results shown in the list." </View.Text> </p>
          <div class="mt-auto flex justify-end">
            <Kit.Button variant=#primary onClick={_ => Signal.set(open_, false)}> <View.Text> "Apply" </View.Text> </Kit.Button>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Drawer = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full items-center justify-center overflow-hidden rounded-lg">
      <Kit.Button variant=#primary onClick={_ => Signal.set(open_, true)}> <View.Text> "Open drawer" </View.Text> </Kit.Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 bg-neutral-900/40" onClick={_ => Signal.set(open_, false)} />
        <div class="absolute bottom-0 left-0 z-20 w-full rounded-t-2xl border-t border-neutral-200 bg-white p-5 shadow-2xl">
          <div class="mx-auto mb-4 h-1 w-10 rounded-full bg-neutral-300" />
          <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Share" </View.Text> </h3>
          <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Swipe down or tap the backdrop to dismiss." </View.Text> </p>
          <div class="mt-4 flex gap-2">
            <Kit.Button variant=#secondary onClick={_ => Signal.set(open_, false)}> <View.Text> "Copy link" </View.Text> </Kit.Button>
            <Kit.Button variant=#primary onClick={_ => Signal.set(open_, false)}> <View.Text> "Send" </View.Text> </Kit.Button>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Toast = {
  @jsx.component
  let make = () => {
    let show = Signal.make(false)
    <div class="relative h-40 w-full max-w-md">
      <Kit.Button
        variant=#primary
        onClick={_ => {
          Signal.set(show, true)
          Ui.setTimeout(() => Signal.set(show, false), 2600)
        }}>
        <View.Text> "Show toast" </View.Text>
      </Kit.Button>
      <View.Show when_={Prop.signal(show)}>
        <div class="absolute bottom-2 right-2 flex w-72 items-start gap-3 rounded-lg border border-neutral-200 bg-white p-3 shadow-xl">
          <span class="mt-0.5 font-semibold text-neutral-900"> <View.Text> "✓" </View.Text> </span>
          <div class="flex-1">
            <p class="text-sm font-medium text-neutral-900"> <View.Text> "Changes saved" </View.Text> </p>
            <p class="text-xs text-neutral-500"> <View.Text> "Your profile has been updated." </View.Text> </p>
          </div>
          <button class="text-sm text-neutral-500 hover:text-neutral-900" onClick={_ => Signal.set(show, false)}>
            <View.Text> "Undo" </View.Text>
          </button>
        </div>
      </View.Show>
    </div>
  }
}

module Table = {
  @jsx.component
  let make = () => {
    let rows = [
      ("INV-001", "Paid", "$250.00"),
      ("INV-002", "Pending", "$150.00"),
      ("INV-003", "Unpaid", "$350.00"),
    ]
    <div class="w-96 overflow-hidden rounded-lg border border-neutral-200">
      <table class="w-full text-sm">
        <thead class="bg-neutral-50 text-left text-xs uppercase tracking-wide text-neutral-500">
          <tr>
            <th class="px-4 py-2 font-medium"> <View.Text> "Invoice" </View.Text> </th>
            <th class="px-4 py-2 font-medium"> <View.Text> "Status" </View.Text> </th>
            <th class="px-4 py-2 text-right font-medium"> <View.Text> "Amount" </View.Text> </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-neutral-100">
          <View.For
            each={Prop.static(rows)}
            render={row => {
              let (inv, status, amount) = row
              <tr class="text-neutral-700">
                <td class="px-4 py-2 font-medium text-neutral-900"> <View.Text> {inv} </View.Text> </td>
                <td class="px-4 py-2"> <View.Text> {status} </View.Text> </td>
                <td class="px-4 py-2 text-right tabular-nums"> <View.Text> {amount} </View.Text> </td>
              </tr>
            }}
          />
        </tbody>
      </table>
    </div>
  }
}

module DataTable = {
  type row = {name: string, role: string, status: string}
  @jsx.component
  let make = () => {
    let source = [
      {name: "Ada Lovelace", role: "Owner", status: "Active"},
      {name: "Grace Hopper", role: "Admin", status: "Active"},
      {name: "Alan Turing", role: "Member", status: "Invited"},
      {name: "Katherine Johnson", role: "Member", status: "Active"},
    ]
    let query = Signal.make("")
    let asc = Signal.make(true)
    let rows = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      let filtered = source->Array.filter(r => r.name->String.toLowerCase->String.includes(q))
      let sorted = filtered->Array.toSorted((a, b) => String.compare(a.name, b.name))
      Signal.get(asc) ? sorted : sorted->Array.toReversed
    })
    <div class="w-[28rem] space-y-3">
      <div class="flex items-center justify-between">
        <Kit.Input
          extraClass="max-w-48"
          type_="search"
          placeholder="Filter people…"
          onInput={e => Signal.set(query, Ui.inputValue(e))}
        />
        <Kit.Button variant=#secondary onClick={_ => Signal.update(asc, v => !v)}>
          <View.Text> "Sort name " </View.Text>
          <View.Text> {Computed.make(() => Signal.get(asc) ? "↑" : "↓")} </View.Text>
        </Kit.Button>
      </div>
      <div class="overflow-hidden rounded-lg border border-neutral-200">
        <table class="w-full text-sm">
          <thead class="bg-neutral-50 text-left text-xs uppercase tracking-wide text-neutral-500">
            <tr>
              <th class="px-4 py-2 font-medium"> <View.Text> "Name" </View.Text> </th>
              <th class="px-4 py-2 font-medium"> <View.Text> "Role" </View.Text> </th>
              <th class="px-4 py-2 font-medium"> <View.Text> "Status" </View.Text> </th>
            </tr>
          </thead>
          <tbody class="divide-y divide-neutral-100">
            <View.For
              each={Prop.signal(rows)}
              by={r => r.name}
              render={r =>
                <tr class="text-neutral-700">
                  <td class="px-4 py-2 font-medium text-neutral-900"> <View.Text> {r.name} </View.Text> </td>
                  <td class="px-4 py-2"> <View.Text> {r.role} </View.Text> </td>
                  <td class="px-4 py-2"> <View.Text> {r.status} </View.Text> </td>
                </tr>}
            />
          </tbody>
        </table>
      </div>
    </div>
  }
}

module Chart = {
  @jsx.component
  let make = () => {
    let bars = [("Mon", 40), ("Tue", 72), ("Wed", 55), ("Thu", 88), ("Fri", 63), ("Sat", 30), ("Sun", 20)]
    <div class="w-96">
      <div class="flex h-40 items-end gap-2 border-b border-l border-neutral-200 p-2">
        <View.For
          each={Prop.static(bars)}
          render={item => {
            let (_l, v) = item
            <div class="flex flex-1 items-end justify-center">
              <div
                class="w-full rounded-t bg-neutral-900"
                style={"height:" ++ Int.toString(v) ++ "%"}
              />
            </div>
          }}
        />
      </div>
      <div class="mt-1 flex gap-2 px-2">
        <View.For
          each={Prop.static(bars)}
          render={item => {
            let (l, _v) = item
            <div class="flex-1 text-center text-xs text-neutral-400"> <View.Text> {l} </View.Text> </div>
          }}
        />
      </div>
    </div>
  }
}

module Carousel = {
  @jsx.component
  let make = () => {
    let idx = Signal.make(0)
    let slides = ["Slide 1", "Slide 2", "Slide 3"]
    let total = Array.length(slides)
    let track = Computed.make(() => "transform:translateX(-" ++ Int.toString(Signal.get(idx) * 100) ++ "%)")
    <div class="w-80">
      <div class="relative overflow-hidden rounded-lg border border-neutral-200">
        <div class="flex transition-transform duration-300" style={Prop.signal(track)}>
          <View.For
            each={Prop.static(slides)}
            render={s =>
              <div class="flex aspect-video w-80 shrink-0 items-center justify-center bg-neutral-100 text-lg font-medium text-neutral-500">
                <View.Text> {s} </View.Text>
              </div>}
          />
        </div>
        <button
          class="absolute left-2 top-1/2 flex size-8 -translate-y-1/2 items-center justify-center rounded-full border border-neutral-200 bg-white/90 hover:bg-white"
          onClick={_ => Signal.update(idx, i => i > 0 ? i - 1 : 0)}>
          <View.Text> "‹" </View.Text>
        </button>
        <button
          class="absolute right-2 top-1/2 flex size-8 -translate-y-1/2 items-center justify-center rounded-full border border-neutral-200 bg-white/90 hover:bg-white"
          onClick={_ => Signal.update(idx, i => i < total - 1 ? i + 1 : i)}>
          <View.Text> "›" </View.Text>
        </button>
      </div>
      <div class="mt-3 flex justify-center gap-1.5">
        <View.For
          each={Prop.static(Array.fromInitializer(~length=total, i => i))}
          render={i => {
            let cls = Computed.make(() =>
              "size-2 rounded-full transition-colors " ++ (Signal.get(idx) == i ? "bg-neutral-900" : "bg-neutral-300")
            )
            <span class={Prop.signal(cls)} />
          }}
        />
      </div>
    </div>
  }
}

module Combobox = {
  @jsx.component
  let make = () => {
    let all = ["Next.js", "SvelteKit", "Remix", "Astro", "Nuxt", "SolidStart", "Qwik City"]
    let query = Signal.make("")
    let open_ = Signal.make(false)
    let value = Signal.make("")
    let filtered = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      all->Array.filter(o => o->String.toLowerCase->String.includes(q))
    })
    let display = Computed.make(() => {
      let v = Signal.get(value)
      v == "" ? "Select framework…" : v
    })
    <div class="relative w-64">
      <button
        class={Ui.inputBase ++ " flex items-center justify-between text-left"}
        onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> {display} </View.Text>
        <span class="text-neutral-400"> <View.Text> "⌄" </View.Text> </span>
      </button>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 w-full rounded-md border border-neutral-200 bg-white p-1 shadow-lg">
          <input
            class={Ui.inputBase ++ " mb-1"}
            placeholder="Search…"
            onInput={e => Signal.set(query, Ui.inputValue(e))}
          />
          <ul class="max-h-40 overflow-y-auto">
            <View.For
              each={Prop.signal(filtered)}
              render={o =>
                <li>
                  <button
                    class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                    onClick={_ => {
                      Signal.set(value, o)
                      Signal.set(open_, false)
                    }}>
                    <View.Text> {o} </View.Text>
                  </button>
                </li>}
            />
          </ul>
        </div>
      </View.Show>
    </div>
  }
}

module Command = {
  @jsx.component
  let make = () => {
    let all = ["New file", "New folder", "Search", "Go to settings", "Toggle theme", "Sign out"]
    let query = Signal.make("")
    let filtered = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      all->Array.filter(o => o->String.toLowerCase->String.includes(q))
    })
    <div class="w-80 overflow-hidden rounded-lg border border-neutral-200 shadow-sm">
      <input
        class="w-full border-b border-neutral-200 px-4 py-3 text-sm focus:outline-none"
        placeholder="Type a command…"
        onInput={e => Signal.set(query, Ui.inputValue(e))}
      />
      <ul class="max-h-52 overflow-y-auto p-1">
        <View.For
          each={Prop.signal(filtered)}
          render={o =>
            <li>
              <button class="flex w-full items-center gap-2 rounded px-3 py-2 text-left text-sm text-neutral-700 hover:bg-neutral-100">
                <span class="text-neutral-400"> <View.Text> "›" </View.Text> </span>
                <View.Text> {o} </View.Text>
              </button>
            </li>}
        />
      </ul>
    </div>
  }
}

module Calendar = {
  @jsx.component
  let make = () => {
    let selected = Signal.make(14)
    let days = Array.fromInitializer(~length=30, i => i + 1)
    let dow = ["S", "M", "T", "W", "T", "F", "S"]
    <div class="w-72 rounded-lg border border-neutral-200 p-3">
      <div class="mb-2 flex items-center justify-between px-1">
        <span class="text-sm font-medium text-neutral-900"> <View.Text> "July 2026" </View.Text> </span>
        <span class="text-xs text-neutral-400"> <View.Text> "‹  ›" </View.Text> </span>
      </div>
      <div class="grid grid-cols-7 gap-1 text-center">
        <View.For
          each={Prop.static(dow)}
          render={d => <span class="py-1 text-xs text-neutral-400"> <View.Text> {d} </View.Text> </span>}
        />
        <View.For
          each={Prop.static(days)}
          render={d => {
            let cls = Computed.make(() =>
              "flex size-8 items-center justify-center rounded-full text-sm transition-colors " ++ (
                Signal.get(selected) == d
                  ? "bg-neutral-900 text-white"
                  : "text-neutral-700 hover:bg-neutral-100"
              )
            )
            <button class={Prop.signal(cls)} onClick={_ => Signal.set(selected, d)}>
              <View.Text> {Int.toString(d)} </View.Text>
            </button>
          }}
        />
      </div>
    </div>
  }
}

module DatePicker = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    let day = Signal.make(14)
    let label = Computed.make(() => "July " ++ Int.toString(Signal.get(day)) ++ ", 2026")
    let days = Array.fromInitializer(~length=30, i => i + 1)
    <div class="relative w-64">
      <button
        class={Ui.inputBase ++ " flex items-center justify-between text-left"}
        onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> {label} </View.Text>
        <span class="text-neutral-400"> <View.Text> "📅" </View.Text> </span>
      </button>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 w-64 rounded-lg border border-neutral-200 bg-white p-3 shadow-xl">
          <div class="grid grid-cols-7 gap-1 text-center">
            <View.For
              each={Prop.static(days)}
              render={d => {
                let cls = Computed.make(() =>
                  "flex size-8 items-center justify-center rounded-full text-sm " ++ (
                    Signal.get(day) == d ? "bg-neutral-900 text-white" : "text-neutral-700 hover:bg-neutral-100"
                  )
                )
                <button
                  class={Prop.signal(cls)}
                  onClick={_ => {
                    Signal.set(day, d)
                    Signal.set(open_, false)
                  }}>
                  <View.Text> {Int.toString(d)} </View.Text>
                </button>
              }}
            />
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Resizable = {
  @jsx.component
  let make = () => {
    let split = Signal.make(55)
    let leftStyle = Computed.make(() => "width:" ++ Int.toString(Signal.get(split)) ++ "%")
    let rightStyle = Computed.make(() => "width:" ++ Int.toString(100 - Signal.get(split)) ++ "%")
    <div class="w-96 space-y-3">
      <div class="flex h-40 overflow-hidden rounded-lg border border-neutral-200">
        <div class="flex items-center justify-center bg-neutral-50 text-sm text-neutral-500" style={Prop.signal(leftStyle)}>
          <View.Text> "Panel A" </View.Text>
        </div>
        <div class="w-1.5 cursor-col-resize bg-neutral-200" />
        <div class="flex items-center justify-center bg-white text-sm text-neutral-500" style={Prop.signal(rightStyle)}>
          <View.Text> "Panel B" </View.Text>
        </div>
      </div>
      <input
        type_="range"
        min="20"
        max="80"
        value={Prop.signal(Computed.make(() => Signal.get(split)->Int.toString))}
        class="w-full accent-neutral-900"
        onInput={e => Signal.set(split, Ui.inputValue(e)->Int.fromString->Option.getOr(50))}
      />
    </div>
  }
}

module Navbar = {
  @jsx.component
  let make = () =>
    <div class="w-full max-w-2xl rounded-lg border border-neutral-200 bg-white">
      <div class="flex items-center justify-between px-4 py-3">
        <div class="flex items-center gap-6">
          <span class="font-semibold text-neutral-900"> <View.Text> "Acme" </View.Text> </span>
          <nav class="hidden gap-4 text-sm text-neutral-600 sm:flex">
            <a class="hover:text-neutral-900" href="#"> <View.Text> "Product" </View.Text> </a>
            <a class="hover:text-neutral-900" href="#"> <View.Text> "Pricing" </View.Text> </a>
            <a class="hover:text-neutral-900" href="#"> <View.Text> "Docs" </View.Text> </a>
          </nav>
        </div>
        <div class="flex items-center gap-2">
          <Kit.Button variant=#ghost> <View.Text> "Sign in" </View.Text> </Kit.Button>
          <Kit.Button variant=#primary> <View.Text> "Get started" </View.Text> </Kit.Button>
        </div>
      </div>
    </div>
}

module Menubar = {
  @jsx.component
  let make = () =>
    <div class="flex w-full max-w-lg items-center gap-1 rounded-lg border border-neutral-200 bg-white p-1 text-sm">
      <View.For
        each={Prop.static(["File", "Edit", "View", "Help"])}
        render={m =>
          <button class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100"> <View.Text> {m} </View.Text> </button>}
      />
    </div>
}

module NavigationMenu = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative w-full max-w-lg">
      <div class="flex items-center gap-1 rounded-lg border border-neutral-200 bg-white p-1 text-sm">
        <button
          class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100"
          onClick={_ => Signal.update(open_, v => !v)}>
          <View.Text> "Products ⌄" </View.Text>
        </button>
        <a class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Pricing" </View.Text> </a>
        <a class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Company" </View.Text> </a>
      </div>
      <View.Show when_={Prop.signal(open_)}>
        <Kit.Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 grid w-96 grid-cols-2 gap-1 rounded-lg border border-neutral-200 bg-white p-2 shadow-xl">
          <View.For
            each={Prop.static([
              ("Analytics", "Understand your traffic"),
              ("Automations", "Build no-code workflows"),
              ("Reports", "Share insights"),
              ("Integrations", "Connect your stack"),
            ])}
            render={item => {
              let (t, d) = item
              <a class="rounded-md p-3 hover:bg-neutral-50" href="#">
                <p class="text-sm font-medium text-neutral-900"> <View.Text> {t} </View.Text> </p>
                <p class="text-xs text-neutral-500"> <View.Text> {d} </View.Text> </p>
              </a>
            }}
          />
        </div>
      </View.Show>
    </div>
  }
}

module Sidebar = {
  @jsx.component
  let make = () =>
    <div class="flex h-56 w-56 flex-col rounded-lg border border-neutral-200 bg-neutral-50 p-2">
      <div class="px-2 py-1.5 text-sm font-semibold text-neutral-900"> <View.Text> "Workspace" </View.Text> </div>
      <nav class="mt-1 space-y-0.5 text-sm">
        <a class="block rounded-md bg-neutral-900 px-2 py-1.5 text-white" href="#"> <View.Text> "Dashboard" </View.Text> </a>
        <a class="block rounded-md px-2 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Projects" </View.Text> </a>
        <a class="block rounded-md px-2 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Reports" </View.Text> </a>
        <a class="block rounded-md px-2 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Settings" </View.Text> </a>
      </nav>
    </div>
}

module LandingPage = {
  @jsx.component
  let make = () =>
    <div class="w-full max-w-2xl overflow-hidden rounded-lg border border-neutral-200 bg-white">
      <div class="flex items-center justify-between border-b border-neutral-200 px-5 py-3">
        <span class="font-semibold text-neutral-900"> <View.Text> "Acme" </View.Text> </span>
        <Kit.Button variant=#primary> <View.Text> "Start free" </View.Text> </Kit.Button>
      </div>
      <div class="px-8 py-12 text-center">
        <span class="inline-flex rounded-full border border-neutral-300 px-3 py-1 text-xs text-neutral-600">
          <View.Text> "New · v2 is here" </View.Text>
        </span>
        <h2 class="mx-auto mt-4 max-w-md text-3xl font-bold tracking-tight text-neutral-900">
          <View.Text> "Ship your product faster" </View.Text>
        </h2>
        <p class="mx-auto mt-3 max-w-sm text-sm text-neutral-500">
          <View.Text> "One primary action, front and center — everything on the page builds toward it." </View.Text>
        </p>
        <div class="mt-6 flex justify-center gap-3">
          <Kit.Button variant=#primary> <View.Text> "Get started" </View.Text> </Kit.Button>
          <Kit.Button variant=#secondary> <View.Text> "Book a demo" </View.Text> </Kit.Button>
        </div>
      </div>
    </div>
}

let get = (id: string): option<View.node> =>
  switch id {
  | "button" => Some(<Button />)
  | "input" => Some(<Input />)
  | "textarea" => Some(<Textarea />)
  | "badge" => Some(<Badge />)
  | "avatar" => Some(<Avatar />)
  | "checkbox" => Some(<Checkbox />)
  | "switch" => Some(<Switch />)
  | "slider" => Some(<Slider />)
  | "progress" => Some(<Progress />)
  | "spinner" => Some(<Spinner />)
  | "skeleton" => Some(<Skeleton />)
  | "separator" => Some(<Separator />)
  | "label" => Some(<Label />)
  | "kbd" => Some(<Kbd />)
  | "typography" => Some(<Typography />)
  | "radio-group" => Some(<RadioGroup />)
  | "toggle" => Some(<Toggle />)
  | "toggle-group" => Some(<ToggleGroup />)
  | "aspect-ratio" => Some(<AspectRatio />)
  | "scroll-area" => Some(<ScrollArea />)
  | "input-otp" => Some(<InputOtp />)
  | "card" => Some(<Card />)
  | "alert" => Some(<Alert />)
  | "tabs" => Some(<Tabs />)
  | "accordion" => Some(<Accordion />)
  | "collapsible" => Some(<Collapsible />)
  | "dialog" => Some(<Dialog />)
  | "alert-dialog" => Some(<AlertDialog />)
  | "tooltip" => Some(<Tooltip />)
  | "breadcrumb" => Some(<Breadcrumb />)
  | "pagination" => Some(<Pagination />)
  | "empty-state" => Some(<EmptyState />)
  | "field" => Some(<Field />)
  | "form" => Some(<Form />)
  | "button-group" => Some(<ButtonGroup />)
  | "input-group" => Some(<InputGroup />)
  | "select" => Some(<Select />)
  | "dropdown-menu" => Some(<DropdownMenu />)
  | "context-menu" => Some(<ContextMenu />)
  | "popover" => Some(<Popover />)
  | "hover-card" => Some(<HoverCard />)
  | "sheet" => Some(<Sheet />)
  | "drawer" => Some(<Drawer />)
  | "toast" => Some(<Toast />)
  | "table" => Some(<Table />)
  | "data-table" => Some(<DataTable />)
  | "chart" => Some(<Chart />)
  | "carousel" => Some(<Carousel />)
  | "combobox" => Some(<Combobox />)
  | "command" => Some(<Command />)
  | "calendar" => Some(<Calendar />)
  | "date-picker" => Some(<DatePicker />)
  | "resizable" => Some(<Resizable />)
  | "navbar" => Some(<Navbar />)
  | "menubar" => Some(<Menubar />)
  | "navigation-menu" => Some(<NavigationMenu />)
  | "sidebar" => Some(<Sidebar />)
  | "landing-page" => Some(<LandingPage />)
  | _ => None
  }
