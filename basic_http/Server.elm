effect module Server where { subscription = MySub } exposing (listen)

import Task exposing (Task)

{-| A request from a client 
-}
type alias Request =
  String

listen : Int -> (String -> msg) -> Sub msg
listen prt tagger =
  subscription (Listen prt tagger)


-- SUBSCRIPTIONS

type MySub msg
  = Listen Int (String -> msg)

subMap : (a -> b) -> MySub a -> MySub b
subMap func sub =
  case sub of
    Listen prt tagger ->
      Listen prt (tagger >> func)


-- EFFECT MANAGER

type alias State msg =
  Maybe
    { subs: List (MySub msg)
    , val: Int
    }

init : Task Never (State msg)
init =
  Task.succeed Nothing


-- Effects module handlers

onEffects : Platform.Router msg Request -> List (MySub msg) -> State msg -> Task Never (State msg)
onEffects router newSubs oldState =
  let
    _ = Debug.log "onEffects newSubs: " newSubs
    _ = Debug.log "onEffects oldState: " oldState
  in
    case ( oldState, newSubs ) of
      ( Nothing, [] ) ->
        Task.succeed Nothing
      ( state, [] ) ->
        Task.succeed (Just { subs = newSubs, val = 1 })
      ( Nothing, _ ) ->
        Task.succeed (Just { subs = newSubs, val = 2 })
      ( _, _ ) ->
        Task.succeed (Just { subs = newSubs, val = 3 })


onSelfMsg : Platform.Router msg Request -> Request -> State msg -> Task Never (State msg)
onSelfMsg router dimensions state =
  let
    _ = Debug.log "onSelfMsg dimensions: " dimensions
    _ = Debug.log "onSelfMsg state: " state
  in
    case state of
      Nothing ->
        Task.succeed Nothing
      Just { subs } ->
        Task.succeed state
