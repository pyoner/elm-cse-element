module CustomSearch.Types exposing (..)

import CustomSearch.Attributes exposing (Attributes)


type Component
    = Search Gname ElementId
    | SearchBoxResults Gname ( ElementId, ElementId )
    | SearchBoxOnly Gname ElementId
    | SearchResultsOnly Gname ElementId


type Event
    = Load (Result Error Cx)
    | Render GnameResult
    | ClearAllResults GnameResult
    | Execute QueryResult
    | PrefillQuery QueryResult
    | InputQuery QueryResult
    | Clear (Result Error ElementId)
    | DecodeError Error


type alias Gname =
    String


type alias Cx =
    String


type alias Config =
    { div : ElementId
    , tag : String
    , attributes : Attributes
    , gname : Gname
    }


type alias Error =
    String


type alias QueryResult =
    Result Error ( Gname, Query )


type alias GnameResult =
    Result String Gname


type alias ElementId =
    String


type alias Query =
    String
