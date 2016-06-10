port module Server exposing (listen, bind)

type alias Binding =
  { method : String
  , route  : String
  }

type alias BindingData =
  { prt : Int
  , bindings : List Binding
  }


port recv : (String -> msg) -> Sub msg

port binder : BindingData -> Cmd msg

bind : BindingData -> Cmd msg
bind bindings =
  binder bindings

listen : (String -> msg) -> Sub msg
listen tagger =
  recv tagger
