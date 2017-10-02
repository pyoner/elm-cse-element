module CustomSearch.Types.Common exposing (..)


type alias Gname =
    String


type Size
    = SizeInt Int
    | SizeString String


type SearchParameter
    = CountryRestricts String
    | GeoLocation String
    | AsSiteSearch String
    | AsOrQuery String
    | SortBy String
    | Filter String


type SafeSearch
    = Moderate
    | Off
    | Active
