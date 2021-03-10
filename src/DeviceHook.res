@ocaml.doc("Returns the device based on the provided `deviceResolver` function.
This hook will automatically listen to the window size changes and call the `deviceResolver` accordingly.

The provided function will receive the whole `WindowHook.t` object and can return any type.

See the `Make` functor to build your own custom hook that doesn't require any `deviceResolver` function.

_The hook works only on the client side._

The following example uses the string type, but you can use the a (polymorphic) variant to make your hook safer:

```
let device = DeviceHook.use(({WindowHook.innerWidth: innerWidth}) =>
  switch () {
  | _ when innerWidth >= 375 && innerWidth < 768 => \"mobile\"
  | _ when innerWidth >= 768 && innerWidth < 1024 => \"tablet\"
  | _ when innerWidth >= 1024 => \"desktop\"
  | _ => \"unknown\"
  }
)

<div>
  {switch device {
  | None => \"Rendered from the server side\"
  | Some((\"mobile\" | \"tablet\" | \"desktop\") as device) => `Rendered from the client side, device is ${device}`
  | Some(\"unknown\" | _) => \"Rendered from the client side, unknown device\"
  }->React.string}
</div>
```
")
let use = deviceResolver => {
  let window = WindowHook.use()

  let (device, setDevice) = React.useState(() => window->Belt.Option.map(deviceResolver))

  React.useEffect2(() => {
    switch window {
    | None => ignore()
    | Some(window) =>
      Js.log("Setting device")
      setDevice(_ => Some(deviceResolver(window)))
    }

    None
  }, (
    window->Belt.Option.map(window => window.innerHeight),
    window->Belt.Option.map(window => window.innerWidth),
  ))

  device
}

@ocaml.doc("Functor to create a custom `DeviceHook` to use throughout your whole application.
Will return a hook module containing a `use` function.

The following example uses the string type, but you can use the a (polymorphic) variant to make your hook safer:

```
module MyDeviceHook = DeviceHook.Make({
  type t = string

  let resolve = ({WindowHook.innerWidth: innerWidth}) =>
    switch () {
    | _ when innerWidth >= 375 && innerWidth < 768 => \"mobile\"
    | _ when innerWidth >= 768 && innerWidth < 1024 => \"tablet\"
    | _ when innerWidth >= 1024 => \"desktop\"
    | _ => \"unknown\"
    }
})
```
")
module Make = (
  Resolver: {
    type t

    let resolve: WindowHook.t => t
  },
) => {
  @ocaml.doc("Returns the current device.
See the `DeviceHook.use` function documentation for more.

_The hook works only on the client side._

The following example uses the string type, but you can use the a (polymorphic) variant to make your hook safer:

```
let device = MyDeviceHook.use()

<div>
  {switch device {
  | None => \"Rendered from the server side\"
  | Some((\"mobile\" | \"tablet\" | \"desktop\") as device) => `Rendered from the client side, device is ${device}`
  | Some(\"unknown\" | _) => \"Rendered from the client side, unknown device\"
  }->React.string}
</div>
```
")
  let use = () => use(Resolver.resolve)
}
