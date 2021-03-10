module WindowListeners = {
  @react.component
  let make = () => {
    let (windowClicks, setWindowClicks) = React.useState(() => 0)

    let ((mousePositionX, mousePositionY), setMousePosition) = React.useState(() => (0, 0))

    WindowListenersHook.Click.use0(_event => {
      setWindowClicks(clicks => clicks + 1)
    })

    WindowListenersHook.MouseMove.use0(event => {
      setMousePosition(_ => (event->Webapi.Dom.MouseEvent.x, event->Webapi.Dom.MouseEvent.y))
    })

    <div>
      <div> {"Window events"->React.string} </div>
      <div> {`Window clicks ${windowClicks->Belt.Int.toString}`->React.string} </div>
      <div>
        {`Mouse position x:${mousePositionX->Belt.Int.toString}, y:${mousePositionY->Belt.Int.toString}`->React.string}
      </div>
    </div>
  }
}

module OpenFolder = {
  @react.component
  let make = () => {
    let (disabled, setDisabled) = React.useState(() => false)

    let {files, openFolder, openFolderProps} = OpenFolderHook.use()

    React.useEffect1(() => {
      if files->Belt.Option.isSome {
        Js.log("Files changed")
      }

      None
    }, [files])

    <div>
      <OpenFolderHook.Input openFolderProps accept="image/jpeg" disabled multiple=true />
      <div> {"Open Folder Hook"->React.string} </div>
      <div>
        <button type_="checkbox" onClick={_ => setDisabled(not)}>
          {`${disabled ? "Enable" : "Disable"} input`->React.string}
        </button>
      </div>
      {switch files {
      | None | Some([]) => <div> {"No file open"->React.string} </div>
      | Some(files) =>
        <div>
          <div> {"All opened files:"->React.string} </div>
          {files
          ->Js.Array2.map(file =>
            <div key={file->Webapi.File.name}> {file->Webapi.File.name->React.string} </div>
          )
          ->React.array}
        </div>
      }}
      <div />
      <button disabled onClick={_ => openFolder()}>
        {"Click to open the folder"->React.string}
      </button>
    </div>
  }
}

module Device = {
  module Resolver = {
    @deriving(jsConverter)
    type t = [#unsupported | #mobile | #tablet | #desktop]

    let resolve = ({WindowHook.innerWidth: innerWidth}) =>
      switch () {
      | _ when innerWidth < 375 => #unsupported
      | _ when innerWidth < 768 => #mobile
      | _ when innerWidth < 1024 => #tablet
      | _ => #desktop
      }
  }

  module DeviceHook = DeviceHook.Make(Resolver)

  @react.component
  let make = () => {
    let device = DeviceHook.use()

    <div>
      <div>
        {`Current device (based on screen size): ${device->Belt.Option.mapWithDefault(
            "Unknown",
            Resolver.tToJs,
          )}`->React.string}
      </div>
    </div>
  }
}

module Window = {
  @react.component
  let make = () => {
    let window = WindowHook.use()

    <div>
      <div> {"Window data"->React.string} </div>
      {switch window {
      | None => React.null
      | Some({innerWidth, innerHeight, outerWidth, outerHeight, scrollX, scrollY}) => <>
          <div>
            {`Window inner size width:${innerWidth->Belt.Int.toString}, height:${innerHeight->Belt.Int.toString}`->React.string}
          </div>
          <div>
            {`Window outer size width:${outerWidth->Belt.Int.toString}, height:${outerHeight->Belt.Int.toString}`->React.string}
          </div>
          <div
            style={ReactDOM.Style.make(
              ~height="1000px",
              ~width="2000px",
              ~display="flex",
              ~alignItems="center",
              ~justifyContent="center",
              (),
            )}>
            {`Window scroll x:${scrollX->Belt.Float.toString}, y:${scrollY->Belt.Float.toString}`->React.string}
          </div>
        </>
      }}
    </div>
  }
}

module App = {
  @react.component
  let make = () => {
    <div>
      <div> {"ReHooks"->React.string} </div>
      <div> <WindowListeners /> </div>
      <div> <OpenFolder /> </div>
      <div> <Device /> </div>
      <div> <Window /> </div>
    </div>
  }
}

ReactDOM.render(
  <App />,
  Webapi.Dom.document->Webapi.Dom.Document.getElementById("root", _)->Belt.Option.getExn,
)
