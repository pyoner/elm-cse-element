module CustomSearch.Types exposing (..)

{-| Types
@docs Component, Gname, Cx, ElementId, Query, Config
-}

import CustomSearch.Attributes exposing (Attributes)


{-| Component
-}
type Component
    = Search Gname ElementId
    | SearchBoxResults Gname ( ElementId, ElementId )
    | SearchBoxOnly Gname ElementId
    | SearchResultsOnly Gname ElementId


{-| Gname
-}
type alias Gname =
    String


{-| Cx
-}
type alias Cx =
    String


{-| Config
-}
type alias Config =
    { div : ElementId
    , tag : String
    , attributes : Attributes
    , gname : Gname
    }


{-| ElementId
-}
type alias ElementId =
    String


{-| Query
-}
type alias Query =
    String
