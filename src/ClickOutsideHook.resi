@ocaml.doc("Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.
")
let use: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
) => unit

@ocaml.doc("Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.
")
let use0: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
) => unit

@ocaml.doc("Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.
")
let use1: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  array<'a>,
) => unit

@ocaml.doc("Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.
")
let use2: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  ('a, 'b),
) => unit

@ocaml.doc("Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.
")
let use3: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  ('a, 'b, 'c),
) => unit

@ocaml.doc("Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.
")
let use4: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  ('a, 'b, 'c, 'd),
) => unit
