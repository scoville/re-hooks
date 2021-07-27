let use: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
) => unit

let use0: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
) => unit

let use1: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  array<'a>,
) => unit

let use2: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  ('a, 'b),
) => unit

let use3: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  ('a, 'b, 'c),
) => unit

let use4: (
  ~refs: array<React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>>,
  ~onClick: bool=?,
  ~onTouch: bool=?,
  unit => WindowListenersHook.MouseDown.return,
  ('a, 'b, 'c, 'd),
) => unit
