@ocaml.doc("You need to mount this component in your DOM so that it can be used to handle the open folder and
files state logic. The component _must_ receive the `openFolderProps` prop
that's returned by the `OpenFolderHook.use` function.

The component accepts some props you'd expect from a simple `input` with type `file`:

```
<OpenFolderHook.Input openFolderProps accept=\"image/*\" disabled multiple=true />
```")
module Input = {
  type openFolderProps = {
    ref: React.ref<Js.Nullable.t<Webapi.Dom.Element.t>>,
    setFiles: (option<array<Webapi.File.t>> => option<array<Webapi.File.t>>) => unit,
  }

  @react.component
  let make = (~accept=?, ~multiple=?, ~disabled=?, ~openFolderProps as {ref, setFiles}) =>
    <input
      onChange={event => {
        let selectedFiles: Js.Array2.array_like<Webapi.File.t> = ReactEvent.Form.target(
          event,
        )["files"]

        // Because of how Firefox handles the FileList object contained in file inputs
        // We need to force create a new reference to force the UI update
        // https://github.com/facebook/react/issues/18104
        setFiles(_ => Some(Js.Array2.from(selectedFiles)))
      }}
      ref={ReactDOM.Ref.domRef(ref)}
      type_="file"
      ?accept
      ?disabled
      ?multiple
      style={ReactDOM.Style.make(~display="none", ())}
    />
}

type t = {
  files: option<array<Webapi.File.t>>,
  openFolder: unit => unit,
  openFolderProps: Input.openFolderProps,
}

@ocaml.doc("This hook will return the currently selected `files` and an imperative `openFolder` function.
It also returns the `openFolderProps` which must be passed down to the `Input` component provided with this hook.

Be aware that the `files` object reference will always be the same as long as the user doesn't upload any
new files, and can safely be used in a `React.useEffect` dependencies array.

Also, you should use `openFolder` only in events or in `React.useEffect` hooks.

_This hook works only on the client side._

```
let {files, openFolder, openFolderProps} = OpenFolderHook.use()

React.useEffect1(() => {
  // Handle newly loaded files
}, [files])

<div>
  <OpenFolderHook.Input openFolderProps />
  <button onClick={_ => openFolder()}>
    {\"Click to open the folder\"->React.string}
  </button>
</div>
```
")
let use = () => {
  let ref = React.useRef(Js.Nullable.null)

  let (files, setFiles) = React.useState(() => None)

  let openFolder = () => {
    open Webapi.Dom

    let input = ref.current->Js.Nullable.toOption->Belt.Option.flatMap(Element.asHtmlElement)

    switch input {
    | Some(input) when !(input->HtmlElement.hasAttribute("disabled", _)) => input->HtmlElement.click
    | _ => ignore()
    }
  }

  {
    files: files,
    openFolder: openFolder,
    openFolderProps: {
      ref: ref,
      setFiles: setFiles,
    },
  }
}
