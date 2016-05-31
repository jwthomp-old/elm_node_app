port module Spelling exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Debug exposing (log)
import Time exposing (Time, second)
import String


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { 
    word : String
  }

init : (Model, Cmd Msg)
init =
  ( Model "", dbg "started" )


-- UPDATE

type Msg
  = Pong String
  | Tick Time

port dbg  : String -> Cmd msg
port ping : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Pong msg ->
      ( Model msg, dbg <| "Pong: " ++ msg)
    Tick newTime ->
      (model, ping <| toString newTime)


-- SUBSCRIPTIONS

port pong : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ pong Pong
    , Time.every second Tick
    ]


-- VIEW

view : Model -> Html Msg
view model = div [] [ text "data" ]
