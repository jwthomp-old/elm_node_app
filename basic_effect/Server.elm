effect module Server where { subscription = MySub } exposing (listen, Socket)

import Task exposing (Task)

type Socket = Socket

listen : Int -> Task x Socket
listen prt = Task.succeed Socket

type alias Event = {}


-- SUBSCRIPTIONS

type MySub msg
    = MySub (Event -> msg)

subMap : (a -> b) -> MySub a -> MySub b
subMap func (MySub tagger) =
    MySub (tagger >> func)

-- EFFECT MANAGER

type alias State msg =
  Maybe
    { subs : List (MySub msg)
    }


init : Task Never (State msg)
init =
  Task.succeed Nothing

onSelfMsg : Platform.Router msg Event -> Event -> State msg -> Task Never (State msg)
onSelfMsg router dimensions state =
  Task.succeed state

onEffects : Platform.Router msg Event -> List (MySub msg) -> State msg -> Task Never (State msg)
onEffects router newSubs oldState =
  Task.succeed Nothing
