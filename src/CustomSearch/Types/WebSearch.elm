module CustomSearch.Types.WebSearch exposing (..)

import CustomSearch.Types.Common as Common


--Web search
--disableWebSearch : Bool


type WebSearch
    = SafeSearch Common.SafeSearch
    | QueryAddition String
    | ResultSetSize Common.Size
    | SearchParameter Common.SearchParameter
