@ocaml.doc("
Check the element that is clicked or touched exist in the refs or not
If it is yes do nothing
Otherwise call function onClickOutside
")
let use = (~refs, ~onClick=true, ~onTouch=true, onClickOutside) => {
  let listener = element =>
    if (
      !(
        refs->Belt.Array.some(({React.current: current}) =>
          current
          ->Js.Nullable.toOption
          ->Belt.Option.mapWithDefault(false, Webapi.Dom.Element.contains(element))
        )
      )
    ) {
      onClickOutside()
    }

  // Takes a mouse event and return its target as an Html element
  // and apply listener when mouse click
  let mouseDownListener = event =>
    event
    ->Webapi.Dom.MouseEvent.target
    ->Webapi.Dom.EventTarget.unsafeAsElement
    ->{onClick ? listener : ignore}

  // Takes a touch event and return its target as an Html element
  // and apply listener when touch start
  let touchStartListener = event =>
    event
    ->Webapi.Dom.TouchEvent.target
    ->Webapi.Dom.EventTarget.unsafeAsElement
    ->{onTouch ? listener : ignore}

  WindowListenersHook.MouseDown.use0(mouseDownListener)

  WindowListenersHook.TouchStart.use0(touchStartListener)
}
