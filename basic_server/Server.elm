module Server exposing (Server, listen)

import Task exposing (Task)
import Native.Server

type Server = Server

listen : Int -> Task x Server
listen =
  Native.Server.listen
