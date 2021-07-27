type listeners = {
  mouseDownListener: WindowListenersHook.MouseDown.t => WindowListenersHook.MouseDown.return,
  touchStartListener: WindowListenersHook.TouchStart.t => WindowListenersHook.TouchStart.return,
}

let makeListeners = (~refs, ~onClick=true, ~onTouch=true, onClickOutside) => {
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

  {mouseDownListener: mouseDownListener, touchStartListener: touchStartListener}
}

@ocaml.doc("Calls the `onClickOutside` function if the user clicks on a dom element that is _not_ one whitelisted in the `refs` argument.

You can deactivate any on click or on touch events using the `~onClick=false` or `~onTouch=false` arguments.
")
let use = (~refs, ~onClick=true, ~onTouch=true, onClickOutside) => {
  let {mouseDownListener, touchStartListener} = makeListeners(
    ~refs,
    ~onClick,
    ~onTouch,
    onClickOutside,
  )

  WindowListenersHook.MouseDown.use(mouseDownListener)

  WindowListenersHook.TouchStart.use(touchStartListener)
}

@ocaml.doc("Calls the `onClickOutside` function if the user clicks on a dom element that is _not_ one whitelisted in the `refs` argument.

You can deactivate any on click or on touch events using the `~onClick=false` or `~onTouch=false` arguments.
")
let use0 = (~refs, ~onClick=true, ~onTouch=true, onClickOutside) => {
  let {mouseDownListener, touchStartListener} = makeListeners(
    ~refs,
    ~onClick,
    ~onTouch,
    onClickOutside,
  )

  WindowListenersHook.MouseDown.use0(mouseDownListener)

  WindowListenersHook.TouchStart.use0(touchStartListener)
}

@ocaml.doc("Calls the `onClickOutside` function if the user clicks on a dom element that is _not_ one whitelisted in the `refs` argument.

You can deactivate any on click or on touch events using the `~onClick=false` or `~onTouch=false` arguments.
")
let use1 = (~refs, ~onClick=true, ~onTouch=true, onClickOutside, dependencies) => {
  let {mouseDownListener, touchStartListener} = makeListeners(
    ~refs,
    ~onClick,
    ~onTouch,
    onClickOutside,
  )

  WindowListenersHook.MouseDown.use1(mouseDownListener, dependencies)

  WindowListenersHook.TouchStart.use1(touchStartListener, dependencies)
}

@ocaml.doc("Calls the `onClickOutside` function if the user clicks on a dom element that is _not_ one whitelisted in the `refs` argument.

You can deactivate any on click or on touch events using the `~onClick=false` or `~onTouch=false` arguments.
")
let use2 = (~refs, ~onClick=true, ~onTouch=true, onClickOutside, dependencies) => {
  let {mouseDownListener, touchStartListener} = makeListeners(
    ~refs,
    ~onClick,
    ~onTouch,
    onClickOutside,
  )

  WindowListenersHook.MouseDown.use2(mouseDownListener, dependencies)

  WindowListenersHook.TouchStart.use2(touchStartListener, dependencies)
}

@ocaml.doc("Calls the `onClickOutside` function if the user clicks on a dom element that is _not_ one whitelisted in the `refs` argument.

You can deactivate any on click or on touch events using the `~onClick=false` or `~onTouch=false` arguments.
")
let use3 = (~refs, ~onClick=true, ~onTouch=true, onClickOutside, dependencies) => {
  let {mouseDownListener, touchStartListener} = makeListeners(
    ~refs,
    ~onClick,
    ~onTouch,
    onClickOutside,
  )

  WindowListenersHook.MouseDown.use3(mouseDownListener, dependencies)

  WindowListenersHook.TouchStart.use3(touchStartListener, dependencies)
}

@ocaml.doc("Calls the `onClickOutside` function if the user clicks on a dom element that is _not_ one whitelisted in the `refs` argument.

You can deactivate any on click or on touch events using the `~onClick=false` or `~onTouch=false` arguments.
")
let use4 = (~refs, ~onClick=true, ~onTouch=true, onClickOutside, dependencies) => {
  let {mouseDownListener, touchStartListener} = makeListeners(
    ~refs,
    ~onClick,
    ~onTouch,
    onClickOutside,
  )

  WindowListenersHook.MouseDown.use4(mouseDownListener, dependencies)

  WindowListenersHook.TouchStart.use4(touchStartListener, dependencies)
}
