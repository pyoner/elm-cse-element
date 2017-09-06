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


type Size
    = SizeInt Int
    | SizeString String


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


type alias General =
    { gname : Gname
    , autoSearchOnLoad : Bool
    , enableHistory : Bool
    , newWindow : Bool
    , queryParameterName : String
    , resultsUrl : Maybe String
    }


general =
    { autoSearchOnLoad = True
    , enableHistory = True
    , newWindow = True
    , queryParameterName = "q"
    , resultsUrl = Nothing
    }



--enableAutoComplete : Bool


type MatchType
    = Any
    | Ordered
    | Prefix


type alias Autocomplete =
    { matchType : Maybe MatchType
    , maxCompletions : Maybe Int
    , maxPromotions : Maybe Int
    , validLanguages : Maybe String
    }


autocomplete =
    { matchType = Nothing
    , maxCompletions = Nothing
    , maxPromotions = Nothing
    , validLanguages = Nothing
    }



--Refinements


type RefinementStyle
    = Tab
    | Link


type alias Refinements =
    { default : Maybe String
    , style : Maybe RefinementStyle
    }


refinements =
    { default = Nothing
    , style = Nothing
    }



--Image search
--enableImageSearch : Bool
--defaultToImageSearch : Bool


type Layout
    = Classic
    | Column
    | Popup


type alias ImageSearch =
    { resultSetSize : Size
    , layout : Maybe Layout
    , cr : Maybe String
    , gl : Maybe String
    , as_sitesearch : Maybe String
    , as_oq : Maybe String
    , sort_by : Maybe String
    , filter : Maybe String
    }


imageSearch =
    { resultSetSize = SizeInt 10
    , layout = Nothing
    , cr = Nothing
    , gl = Nothing
    , as_sitesearch = Nothing
    , as_oq = Nothing
    , sort_by = Nothing
    , filter = Nothing
    }



--Web search


type SafeSearch
    = Moderate
    | Off
    | Active



--disableWebSearch : Bool


type alias WebSearch =
    { resultSetSize : Size
    , safeSearch : SafeSearch
    , queryAddition : Maybe String
    , cr : Maybe String
    , gl : Maybe String
    , as_sitesearch : Maybe String
    , as_oq : Maybe String
    , sort_by : Maybe String
    , filter : Maybe String
    }


webSearch =
    { resultSetSize = SizeInt 10
    , safeSearch = Off
    , queryAddition = Nothing
    , cr = Nothing
    , gl = Nothing
    , as_sitesearch = Nothing
    , as_oq = Nothing
    , sort_by = Nothing
    , filter = Nothing
    }



--Search results


type alias SearchResults =
    { enableOrderBy : Bool
    , safeSearch : SafeSearch
    , setSize : Size
    , linkTarget : Maybe String
    , noResultsString : Maybe String
    }


searchResults =
    { enableOrderBy = True
    , safeSearch = Off
    , setSize = SizeInt 10
    , linkTarget = Nothing
    , noResultsString = Nothing
    }



--Ads


type alias Ads =
    { client : String
    , enableTest : Bool
    , channel : Maybe String
    }


ads =
    { enableTest = False
    , channel = Nothing
    }



-- Analytics


type alias Analytics =
    { categoryParameter : Maybe String
    , queryParameter : Maybe String
    }



--Component attributes


type Search
    = Web WebSearch
    | Image ImageSearch
    | Both WebSearch ImageSearch


type alias Attributes =
    { general : General
    , search : Search
    , autocomplete : Maybe Autocomplete
    , results : Maybe SearchResults
    , refinements : Maybe Refinements
    , ads : Maybe Ads
    , analytics : Maybe Analytics
    }


attributes =
    { general = general
    , search = Web webSearch
    , autocomplete = Nothing
    , refinements = Nothing
    , results = Nothing
    , ads = Nothing
    , analytics = Nothing
    }
