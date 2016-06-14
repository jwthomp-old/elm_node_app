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
  | Recv String

port dbg : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Started val ->
      (model, dbg "started")
    Fail ->
      ( model, dbg "Fail")
    Succ ->
      (model, dbg "Succ")
    None ->
      (model, Cmd.none)
    Connected socket ->
      (model, dbg <| toString socket)
    Recv data ->
      (model, dbg "received data")
    

-- SUBSCRIPTIONS

port started : (Bool -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  Server.listen 8001 Recv

