module Types exposing (..)

import Attributes.Types exposing (Attributes)


type alias Gname =
    String


type Component
    = Search ElementId
    | SearchBoxResults ( ElementId, ElementId )
    | SearchBoxOnly ElementId
    | SearchResultsOnly ElementId


type Event
    = Load (Result Error Cx)
    | Render GnameResult
    | ClearAllResults GnameResult
    | Execute QueryResult
    | PrefillQuery QueryResult
    | InputQuery QueryResult
    | Clear (Result Error ElementId)
    | DecodeError Error


type alias Cx =
    String


type alias Config =
    { div : ElementId
    , tag : String
    , attributes : Attributes
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
