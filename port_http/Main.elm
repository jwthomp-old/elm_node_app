module Main exposing (main)

import Html exposing (..)
import Html.App as Html
import Dbg exposing (dbg)
import Server

main : Program Never
main =
  Html.program
    { init        = init
    , view        = always <| div [] []
    , update      = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Model =
  {
    bindings : List Server.Binding
  }

init : (Model, Cmd Msg)
init =
  let
    bindings : List Server.Binding
    bindings = 
      [ { method = "GET", route = "/",   handler = rootHandler }
      , { method = "GET", route = "/hi", handler = hiHandler }
      ]
  in
    ({ bindings = bindings }
    , Server.bind 
      { prt = 8001
      , bindings = bindings
      })

rootHandler : Int
rootHandler = 1

hiHandler : Int
hiHandler = 1

-- UPDATE
type Msg
  = None
  | Recv (String, Server.Response)

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    None -> (model, dbg "None")
    Recv (msg, resp) -> (model, Cmd.batch[ Server.respond "foo" resp, dbg ("Recv" ++ msg )])


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Server.listen Recv
