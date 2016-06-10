port module Server exposing (listen, bind, respond, Response)

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


port recv : ((String, Response) -> msg) -> Sub msg

port binder : BindingData -> Cmd msg
port responder : (String, Response) -> Cmd msg

respond : String -> Response -> Cmd msg
respond msg response =
  responder (msg, response)

bind : BindingData -> Cmd msg
bind bindings =
  binder bindings

listen : ((String, Response) -> msg) -> Sub msg
listen tagger =
  recv tagger

