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
