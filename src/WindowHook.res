type t = {
  innerHeight: int,
  innerWidth: int,
  outerHeight: int,
  outerWidth: int,
  scrollX: float,
  scrollY: float,
}

let getWindow = () => {
  innerHeight: Webapi.Dom.window->Webapi.Dom.Window.innerHeight,
  innerWidth: Webapi.Dom.window->Webapi.Dom.Window.innerWidth,
  outerHeight: Webapi.Dom.window->Webapi.Dom.Window.outerHeight,
  outerWidth: Webapi.Dom.window->Webapi.Dom.Window.outerWidth,
  scrollX: Webapi.Dom.window->Webapi.Dom.Window.scrollX,
  scrollY: Webapi.Dom.window->Webapi.Dom.Window.scrollY,
}

@ocaml.doc("All-in-one window hook.
Will return an object with some useful up-to-date data of the window object.

The hook will always returns a `None` value on the backend, if your application works only
on the frontend, you can safely get the data using `Option.getExn` or the safer `Option.getWithDefault`
function with an empty window object as default.

Example:

```
let window = WindowHook.use()

<div>
  {switch window {
  | None => \"Rendered from the server side\"->React.string
  | Some({innerWidth, innerHeight, outerWidth, outerHeight, scrollX, scrollY}) => ...
  }}
</div>
```
")
let use = () => {
  let (client, setClient) = React.useState(() => None)

  WindowListenersHook.Resize.use0(_ =>
    setClient(client =>
      switch client {
      | None => Some(getWindow())
      | Some(client) =>
        Some({
          ...client,
          innerHeight: Webapi.Dom.window->Webapi.Dom.Window.innerHeight,
          innerWidth: Webapi.Dom.window->Webapi.Dom.Window.innerWidth,
          outerHeight: Webapi.Dom.window->Webapi.Dom.Window.outerHeight,
          outerWidth: Webapi.Dom.window->Webapi.Dom.Window.outerWidth,
        })
      }
    )
  )

  WindowListenersHook.Scroll.use0(_ =>
    setClient(client =>
      switch client {
      | None => Some(getWindow())
      | Some(client) =>
        Some({
          ...client,
          scrollX: Webapi.Dom.window->Webapi.Dom.Window.scrollX,
          scrollY: Webapi.Dom.window->Webapi.Dom.Window.scrollY,
        })
      }
    )
  )

  React.useEffect0(() => {
    setClient(_ => Some(getWindow()))

    None
  })

  client
}
