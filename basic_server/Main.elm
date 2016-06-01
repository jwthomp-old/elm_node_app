port module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Server
import Task

main : Program Never
main =
  Html.program
  { init          = init
  , view          =  always <| div [] []
  , update        = update
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
  = Open Server.Server
  | Started Bool
  | None

port dbg : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Open server ->
      (model, dbg <| toString server)
    Started val ->
      (model, Cmd.batch 
        [ dbg "started"
        , Task.perform (always None) (always None) (Server.listen 8001)
        ])
    None ->
      (model, Cmd.none)
    

-- SUBSCRIPTIONS

port started : (Bool -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  started Started

