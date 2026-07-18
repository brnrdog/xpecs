// Backdrop — a full-screen click-catcher that dismisses an open overlay. Reused
// by select, dropdown-menu, popover, combobox, and date-picker.
@jsx.component
let make = (~onClose) => <div class="fixed inset-0 z-10" onClick={_ => onClose()} />
