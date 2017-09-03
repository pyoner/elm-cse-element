module Types exposing (..)


type alias Cx =
    String


type alias Element =
    { gname : String
    , kind : String
    }


type Event
    = Load (Result String Cx)
    | Render (Result String Gname)
    | Execute (Result String ( Gname, Query ))
    | DecodeError String


type alias Gname =
    String


type alias Query =
    String


type alias Config =
    { div : String
    , tag : String
    , gname : Gname
    , attributes : Maybe Attributes
    }


type alias Attributes =
    { --General
      gname : Gname
    , autoSearchOnLoad : Bool
    , enableHistory : Bool
    , queryParameterName : String
    , resultsUrl : String
    , newWindow :
        Bool
        --Autocomplete
    , enableAutoComplete : Bool
    , autoCompleteMatchType : String
    , autoCompleteMaxCompletions : Int
    , autoCompleteMaxPromotions : Int
    , autoCompleteValidLanguages :
        String
        --Refinements
    , defaultToRefinement : String
    , refinementStyle :
        String
        -- Image search
    , enableImageSearch : Bool
    , defaultToImageSearch : Bool
    , imageSearchResultSetSize : Int
    , imageSearchLayout : String
    , image_cr : String
    , image_gl : String
    , image_as_sitesearch : String
    , image_as_oq : String
    , image_sort_by : String
    , image_filter :
        String
        --Web search
    , disableWebSearch : Bool
    , webSearchResultSetSize : Int
    , webSearchSafesearch : String
    , webSearchQueryAddition : String
    , cr : String
    , gl : String
    , as_sitesearch : String
    , as_oq : String
    , sort_by : String
    , filter :
        String
        --Search results
    , enableOrderBy : Bool
    , linkTarget : String
    , noResultsString : String
    , resultSetSize : Int
    , safeSearch :
        String
        --Ads
    , adchannel : String
    , adclient : String
    , adtest :
        String
        --Google Analytics
    , gaCategoryParameter : String
    , gaQueryParameter : String
    }
