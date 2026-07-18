# @ux-archetypes/xote

Accessible UI components for [Xote](https://xote.dev) / ReScript that implement
the [UX Archetypes](https://github.com/brnrdog/ux-archetypes) contracts. Each
component's prop types are **generated from the archetype's `## API` contract**
(`Contracts.res`), so the compiler enforces that the implementation can't drift
from the spec's allowed values.

Styled against [`@ux-archetypes/tokens`](../tokens) via the semantic utilities
(`bg-action`, `text-ink`, …), so re-theming is a token change, not a code change.

## Components

`Button`, `IconButton`, `Link`, `Badge`, `Avatar`, `Kbd`, `Separator`,
`Spinner`, `Input`, `Field`, `Switch`, `Alert`, `Accordion`, `Collapsible`,
`Tabs`, `Tooltip`, `Dialog`, `Select`, `Backdrop`, plus shared `Ui` helpers.

## Install

```sh
npm install @ux-archetypes/xote @ux-archetypes/tokens
```

Peer dependencies: `rescript`, `@rescript/core`, `rescript-signals`, `xote`.

## Use

Add it to your `rescript.json` dependencies (the package builds `namespace:false`,
so its modules are available unqualified):

```json
{ "dependencies": ["@rescript/core", "rescript-signals", "xote", "@ux-archetypes/xote"] }
```

```rescript
<Button variant=#primary onClick={_ => submit()}>
  {React.string("Save")}
</Button>
```

Import the token CSS once at your app entry (see `@ux-archetypes/tokens`):

```css
@import "tailwindcss";
@import "@ux-archetypes/tokens/tailwind.css";
```

## Build

`npm run build` regenerates `Contracts.res` from the archetype specs and compiles
the package with ReScript.
