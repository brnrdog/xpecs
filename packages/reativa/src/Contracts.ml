[@@@warning "-a"]

(* GENERATED FILE — do not edit by hand.
   Run `npm run contracts` (scripts/generate-contracts.mjs) to regenerate.
   Types are derived from the `## API` contracts in the spec markdown. *)

module Badge = struct
  type variant = [ `solid | `soft | `outline ]
end

module Button = struct
  type variant = [ `primary | `secondary | `ghost | `destructive ]
  type size = [ `sm | `md | `lg ]
  type type_ = [ `button | `submit | `reset ]
end

module IconButton = struct
  type variant = [ `solid | `ghost ]
end

module Icon = struct
  type size = [ `xs | `sm | `md | `lg | `xl ]
end

module Link = struct
  type variant = [ `default | `muted ]
end

module RadioGroup = struct
  type orientation = [ `vertical | `horizontal ]
end

module ScrollArea = struct
  type orientation = [ `vertical | `horizontal | `both ]
end

module Separator = struct
  type orientation = [ `horizontal | `vertical ]
end

module Skeleton = struct
  type shape = [ `text | `circle | `rect ]
end

module ToggleGroup = struct
  type type_ = [ `single | `multiple ]
end

module Typography = struct
  type variant = [ `h1 | `h2 | `h3 | `h4 | `body | `small | `muted | `code ]
end

module Accordion = struct
  type type_ = [ `single | `multiple ]
end

module Alert = struct
  type variant = [ `info | `success | `warning | `danger ]
end

module ButtonGroup = struct
  type orientation = [ `horizontal | `vertical ]
end

module Calendar = struct
  type mode = [ `single | `range | `multiple ]
end

module Carousel = struct
  type orientation = [ `horizontal | `vertical ]
end

module Chart = struct
  type type_ = [ `bar | `line | `area | `pie ]
end

module Drawer = struct
  type side = [ `left | `right | `top | `bottom ]
end

module Resizable = struct
  type orientation = [ `horizontal | `vertical ]
end

module Sheet = struct
  type side = [ `left | `right | `top | `bottom ]
end

module Stat = struct
  type trend = [ `up | `down | `flat ]
end

module Tabs = struct
  type orientation = [ `horizontal | `vertical ]
end

module Toast = struct
  type variant = [ `info | `success | `warning | `danger ]
end

module Toolbar = struct
  type orientation = [ `horizontal | `vertical ]
end

module AnnouncementBar = struct
  type variant = [ `neutral | `accent | `warning ]
end

module PricingTable = struct
  type interval = [ `monthly | `yearly ]
end

module Steps = struct
  type orientation = [ `horizontal | `vertical ]
end