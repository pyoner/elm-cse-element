module CustomSearch.Types.ImageSearch exposing (..)

import CustomSearch.Types.Common as Common


--Image search
--enableImageSearch : Bool
--defaultToImageSearch : Bool


type ImageLayout
    = Classic
    | Column
    | Popup


type ImageSearch
    = ResultSetSize Common.Size
    | Layout ImageLayout
    | SearchParameter Common.SearchParameter
