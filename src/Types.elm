module Types exposing (..)

import Attributes.Types exposing (Gname)


type Component
    = Search
    | SearchBox
    | SearchResults
    | SearchBoxOnly
    | SearchResultsOnly


type Event
    = Load (Result Error Cx)
    | Render GnameResult
    | ClearAllResults GnameResult
    | Execute QueryResult
    | PrefillQuery QueryResult
    | InputQuery QueryResult
    | DecodeError Error


type alias Cx =
    String


type alias UIOptions =
    {}


type alias Element =
    { gname : String
    , type_ : String
    , uiOptions : UIOptions
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
