port module ServerPorts exposing (binder, responder)

import Json.Encode

type alias Binding =
  { method : String
  , route  : String
  }

type alias BindingData =
  { prt : Int
  , bindings : List Binding
  }

type alias Response = Json.Encode.Value

port binder : BindingData -> Cmd msg
port responder : (String, Response) -> Cmd msg