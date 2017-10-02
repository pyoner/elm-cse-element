module CustomSearch.Types.SearchResults exposing (..)

import CustomSearch.Types.Common as Common


--Search results


type SearchResults
    = EnableOrderBy Bool
    | SafeSearch Common.SafeSearch
    | SetSize Common.Size
    | LinkTarget String
    | NoResultsString String
