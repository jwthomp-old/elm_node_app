module Main exposing (main)

import Html exposing (..)
import Html.App as Html
import Server
import Dbg exposing (dbg)

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
  (Model, Cmd.none)


-- UPDATE
type Msg
  = None
  | Recv String

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    None -> (model, dbg "None")
    Recv msg -> (model, dbg "Recv")


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Server.listen 8001 Recv
