effect module Server where { subscription = MySub } exposing (listen, Socket)

import Task exposing (Task)

type Socket = Socket

listen : Int -> (String -> msg) -> Sub msg
listen prt tagger =
  subscription (Listen prt tagger)

type alias Event = {}



-- SUBSCRIPTIONS

type MySub msg
    = Listen Int (String -> msg)

subMap : (a -> b) -> MySub a -> MySub b
subMap func sub =
  let
    _ = Debug.log "-------" "subMap end"
    _ = Debug.log "-------" sub
    _ = Debug.log "func" func
    _ = Debug.log "-------" "subMap start"
  in
    case sub of
      Listen prt tagger ->
        Listen prt (tagger >> func) 

-- EFFECT MANAGER

type alias State msg =
  Maybe
    { subs : List (MySub msg)
    }


init : Task Never (State msg)
init =
  let
    _ = Debug.log "---------" "init"
  in
    Task.succeed Nothing

type Msg
  = Receive String

onSelfMsg : Platform.Router msg Event -> Event -> State msg -> Task Never (State msg)
onSelfMsg router dimensions state =
  let
    _ = Debug.log "-------" "onSelfMsg end"
    _ = Debug.log "state" state
    _ = Debug.log "dimensions" dimensions
    _ = Debug.log "router" router
    _ = Debug.log "-------" "onSelfMsg begin"
  in
    Task.succeed state

onEffects : Platform.Router msg Event -> List (MySub msg) -> State msg -> Task Never (State msg)
onEffects router newSubs oldState =
  let
    _ = Debug.log "---------" "onEffects done"
    _ = Debug.log "oldState" oldState
    _ = Debug.log "newSubs" newSubs
    _ = Debug.log "router" router
    _ = Debug.log "---------" "onEffects start"
  in
    Task.succeed Nothing
