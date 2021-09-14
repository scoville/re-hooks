@@ocaml.doc("A collection of window listeners hooks.

The API is the same for all the hooks in this module with the `use`, `use0`, `use1`, etc... hook
functions that will take a listener. The name of the hook is similar to the [`React.useEffectX` hooks](https://rescript-lang.org/docs/react/latest/hooks-effect).

_All the event listeners are disposed when the component is unmounted._

```
@react.component
let make = () => {
  WindowListenersHook.Click.use0(_event => {
    Js.log(\"Click on window\")
  })
}
```

Notice that if in the above example the hook expects the listener to returns `unit`, some hooks will expect a
different return type, like the `BeforeUnload` hook for instance.

It's possible to add your own window listener:

```
module MyEvent = {
  // You first need the add/remove event listener for the event you want to listen to.
  // Here we assume the event will dispatch a `string` value and expects `unit` from the listener.

  @send
  external addEventListener: (Webapi.Dom.Window.t, @as(\"my-event\") _, string => unit) => unit =
    \"addEventListener\"

  @send
  external removeEventListener: (Webapi.Dom.Window.t, @as(\"my-event\") _, string => unit) => unit =
    \"removeEventListener\"

  // Let's include all the hooks in the `MyEvent` module
  include unpack(
    make(
      ~addEventListener=(listener, window) => window->addEventListener(listener),
      ~removeEventListener=(listener, window) => window->removeEventListener(listener),
    )
  )
}
```

You can now use it in a component:

```
@react.component
let make = () => {
  MyEvent.use0(value => {
    Js.log(`Got ${value} from the event emitter`)
  })
}
```
")

module type Listener = {
  type t

  type return

  let use: (t => return) => unit

  let use0: (t => return) => unit

  let use1: (t => return, array<'a>) => unit

  let use2: (t => return, ('a, 'b)) => unit

  let use3: (t => return, ('a, 'b, 'c)) => unit

  let use4: (t => return, ('a, 'b, 'c, 'd)) => unit
}

let make = (
  type t return,
  ~addEventListener: (t => return, Webapi.Dom.Window.t) => unit,
  ~removeEventListener: (t => return, Webapi.Dom.Window.t) => unit,
): module(Listener with type t = t and type return = return) =>
  module(
    {
      type t = t

      type return = return

      let makeListener = listener => {
        Webapi.Dom.window->addEventListener(listener, _)

        Some(() => Webapi.Dom.window->removeEventListener(listener, _))
      }

      let use = listener => React.useEffect(() => makeListener(listener))

      let use0 = listener => React.useEffect0(() => makeListener(listener))

      let use1 = listener => React.useEffect1(() => makeListener(listener))

      let use2 = listener => React.useEffect2(() => makeListener(listener))

      let use3 = listener => React.useEffect3(() => makeListener(listener))

      let use4 = listener => React.useEffect4(() => makeListener(listener))
    }
  )

module KeyUp = unpack(
  make(
    ~addEventListener=Webapi.Dom.Window.addKeyUpEventListener,
    ~removeEventListener=Webapi.Dom.Window.removeKeyUpEventListener,
  )
)

module Click = unpack(
  make(
    ~addEventListener=Webapi.Dom.Window.addClickEventListener,
    ~removeEventListener=Webapi.Dom.Window.removeClickEventListener,
  )
)

module MouseDown = unpack(
  make(
    ~addEventListener=Webapi.Dom.Window.addMouseDownEventListener,
    ~removeEventListener=Webapi.Dom.Window.removeMouseDownEventListener,
  )
)

module MouseMove = unpack(
  make(
    ~addEventListener=Webapi.Dom.Window.addMouseMoveEventListener,
    ~removeEventListener=Webapi.Dom.Window.removeMouseMoveEventListener,
  )
)

module TouchStart = unpack(
  make(
    ~addEventListener=Webapi.Dom.Window.addTouchStartEventListener,
    ~removeEventListener=Webapi.Dom.Window.removeTouchStartEventListener,
  )
)

module Resize = {
  @send
  external addEventListener: (Webapi.Dom.Window.t, @as("resize") _, Dom.event => unit) => unit =
    "addEventListener"

  @send
  external removeEventListener: (Webapi.Dom.Window.t, @as("resize") _, Dom.event => unit) => unit =
    "removeEventListener"

  include unpack(
    make(
      ~addEventListener=(listener, window) => window->addEventListener(listener),
      ~removeEventListener=(listener, window) => window->removeEventListener(listener),
    )
  )
}

module Scroll = {
  @send
  external addEventListener: (Webapi.Dom.Window.t, @as("scroll") _, Dom.event => unit) => unit =
    "addEventListener"

  @send
  external removeEventListener: (Webapi.Dom.Window.t, @as("scroll") _, Dom.event => unit) => unit =
    "removeEventListener"

  include unpack(
    make(
      ~addEventListener=(listener, window) => window->addEventListener(listener),
      ~removeEventListener=(listener, window) => window->removeEventListener(listener),
    )
  )
}

module BeforeUnload = {
  @send
  external addEventListener: (
    Webapi.Dom.Window.t,
    @as("beforeunload") _,
    Dom.event => option<string>,
  ) => unit = "addEventListener"

  @send
  external removeEventListener: (
    Webapi.Dom.Window.t,
    @as("beforeunload") _,
    Dom.event => option<string>,
  ) => unit = "removeEventListener"

  include unpack(
    make(
      ~addEventListener=(listener, window) => window->addEventListener(listener),
      ~removeEventListener=(listener, window) => window->removeEventListener(listener),
    )
  )
}
