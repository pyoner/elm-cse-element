module CustomSearch.Types.General exposing (..)

import CustomSearch.Types.Common as Common


type General
    = Gname Common.Gname
    | AutoSearchOnLoad Bool
    | EnableHistory Bool
    | NewWindow Bool
    | QueryParameterName String
    | ResultsUrl String
