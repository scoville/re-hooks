@@ocaml.doc("Contains several window listeners hooks.
The API is used is always the same, with all the module exposing some `use0`, `use1`, etc...
functions that will take a listener. The name of the hook is based on the one from ReScript React.

_Events are disposed when component are unmounted._

```
@react.component
let make = () => {
  WindowListenersHook.Click.use0(_event => {
    Js.log(\"Click on window\")
  })
}
```

Notice that if in the above example the hook expects the listener to returns `unit`, some hooks will expect a
different type, like the `BeforeUnload` module for instance.


To add your own window listener is also possible, and should be trivial:

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

  // Let's now include all the hooks!
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
