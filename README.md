## ReHooks

A simple React Hooks toolbox written in ReScript.

### Hooks' description

All the hooks are documented in code so that the [official plugin for VScode](https://github.com/rescript-lang/rescript-vscode) can display the documentation most of the time (docs are not displayed for modules and functors unfortunately).

Additionally to the in code documentation you'll find below a short description of what the hooks do and an example for each.

_Feel free to explore the [`example`](./example/index.res) if you want some "real world" examples._

#### ClientOutsideHook

Calls the provided `onClickOutside` function when the user clicks on a dom element that is _not_ whitelisted in the `refs` argument.

You can deactivate the on click or the on touch event using the `~onClick=false` or `~onTouch=false` arguments.

Additionally to the `use` hook this module comes with 5 other hooks `use0` to `use4` that serve the same purpose as the official [`React.useEffectX` hooks](https://rescript-lang.org/docs/react/latest/hooks-effect).

Example:

```rescript
let whitelistedRef = React.useRef(Js.Nullable.null)

let (isDisplayed, setIsDisplayed) = React.useState(() => false)

ClickOutsideHook.use0(~refs=[whitelistedRef], () => setIsDisplayed(_ => false))

<div ref={ReactDOM.Ref.domRef(whitelistedRef)}>
  {`Div below is displayed: ${isDisplayed ? "true" : "false"}`->React.string}
  <div readOnly=true onClick={_ => setIsDisplayed(_ => true)} value=text>
    {(isDisplayed ? "I'm displayed now!" : "Click me")->React.string}
  </div>
</div>
```

#### DeviceHook

In order to use this hook you need to call the `Make` [functor](https://rescript-lang.org/docs/manual/latest/module#module-functions-functors). You only need to do this once for your whole application.

The module passed to the `Make` functor must contain a `resolve` function that takes the result of the `WindowHook` hook and return a value of type `t` which must be defined too.

Like the `WindowHook` hook which `DeviceHook` is based on, it can be used only client side and will always return `None` on the server side.

```rescript
module MyDeviceHook = DeviceHook.Make({
  type t = [#unknown | #mobile | #tablet | #desktop]

  let resolve = ({WindowHook.innerWidth: innerWidth}) =>
    switch () {
    | _ if innerWidth >= 375 && innerWidth < 768 => #mobile
    | _ if innerWidth >= 768 && innerWidth < 1024 => #tablet
    | _ if innerWidth >= 1024 => #desktop
    | _ => #unknown
    }
})
```

Alternatively you can use the `make` function that is stricly equivalent but can feel more familiar to some developers:

```rescript
module MyDeviceHook = unpack(
  DeviceHook.make(~resolve=({innerWidth}): [#mobile | #tablet | #desktop | #unknown] =>
    switch () {
    | _ if innerWidth >= 375 && innerWidth < 768 => #mobile
    | _ if innerWidth >= 768 && innerWidth < 1024 => #tablet
    | _ if innerWidth >= 1024 => #desktop
    | _ => #unknown
    }
  )
)
```

Now our `MyDeviceHook` hook has been defined with our rules, we can use it:

```rescript
let device = MyDeviceHook.use()

<div>
  {switch device {
  | None => "Rendered from the server side"
  | Some((#mobile | #tablet | #desktop) as device) =>
    `Rendered from the client side, device is ${((device :> [#mobile | #tablet | #desktop]) :> string)}`
  | Some(#unknown) => "Rendered from the client side, unknown device"
  }->React.string}
</div>
```

_Notice that we need the double type casting using `:>` only if we intend to use the device type as a string. Also, you can return any type from the `resolve` function._

#### OpenFolderHook

This hook will return the currently selected `files` and an imperative `openFolder` function.
It also returns the `openFolderProps` which must be passed down to the `Input` component provided with this hook.

Be aware that the `files` object reference will always be the same as long as the user doesn't upload any
new files, and can safely be used in a `React.useEffect` dependencies array.

Also, you should use `openFolder` only in events or in `React.useEffect` hooks.

_This hook works only on the client side._

Example:

```
let {files, openFolder, openFolderProps} = OpenFolderHook.use()

React.useEffect1(() => {
  // Handle loaded files
}, [files])

<div>
  // The required hidden input
  <OpenFolderHook.Input openFolderProps />
  // The trigger, it can be any html element.
  // You can also call the `openFolder` function
  // in a `useEffect` hook
  <button onClick={_ => openFolder()}>
    {"Click to open the folder"->React.string}
  </button>
</div>
```

#### WindowHook

All-in-one window hook.
Will return an object with some useful up-to-date data of the `window` object.

The hook will always returns a `None` value on the backend, if your application works only
on the frontend, you can safely get the data using `Belt.Option.getExn` or the safer `Belt.Option.getWithDefault` function with an empty window object as default.

Example:

```
let window = WindowHook.use()

<div>
  {switch window {
  | None => "Rendered from the server side"->React.string
  | Some({innerWidth, innerHeight, outerWidth, outerHeight, scrollX, scrollY}) => ...
  }}
</div>
```

### WindowListenersHook

A collection of window listeners hooks.

The API is the same for all the hooks in this module with the `use`, `use0`, `use1`, etc... hook
functions that will take a listener. The name of the hook is similar to the [`React.useEffectX` hooks](https://rescript-lang.org/docs/react/latest/hooks-effect).

_All the event listeners are disposed when the component is unmounted._

```rescript
@react.component
let make = () => {
  WindowListenersHook.Click.use0(_event => {
    Js.log("Click on window")
  })
}
```

Notice that if in the above example the hook expects the listener to returns `unit`, some hooks will expect a different return type, like the `BeforeUnload` hook for instance.

It's possible to add your own window listener:

```rescript
module MyEvent = {
  // You first need the add/remove event listener for the event you want to listen to.
  // Here we assume the event will dispatch a `string` value and expects `unit` from the listener.

  @send
  external addEventListener: (Webapi.Dom.Window.t, @as("my-event") _, string => unit) => unit =
    "addEventListener"

  @send
  external removeEventListener: (Webapi.Dom.Window.t, @as("my-event") _, string => unit) => unit =
    "removeEventListener"

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

```rescript
@react.component
let make = () => {
  MyEvent.use0(value => {
    Js.log(`Got ${value} from the event emitter`)
  })
}
```
