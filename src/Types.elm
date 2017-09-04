module Types exposing (..)


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


type Event
    = Load (Result Error Cx)
    | Render GnameResult
    | ClearAllResults GnameResult
    | Execute QueryResult
    | PrefillQuery QueryResult
    | InputQuery QueryResult
    | DecodeError Error


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
