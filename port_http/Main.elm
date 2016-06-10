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
  }

init : (Model, Cmd Msg)
init =
  (Model, Server.bind 
    { prt = 8001
    , bindings =
      [ { method = "GET", route = "/" }
      , { method = "GET", route = "/hi" }
      ]})



-- UPDATE
type Msg
  = None
  | Recv String

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    None -> (model, dbg "None")
    Recv msg -> (model, dbg ("Recv" ++ msg ))


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Server.listen Recv
