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
  = Started Bool
  | None
  | Fail
  | Succ
  | Connected Server.Socket

port dbg : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Started val ->
      (model, Cmd.batch 
        [ dbg "started"
        , Task.perform (always Fail) Connected (Server.listen 8001)
        ])
    Fail ->
      ( model, dbg "Fail")
    Succ ->
      (model, dbg "Succ")
    None ->
      (model, Cmd.none)
    Connected socket ->
      (model, dbg <| toString socket)
    

-- SUBSCRIPTIONS

port started : (Bool -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  started Started

