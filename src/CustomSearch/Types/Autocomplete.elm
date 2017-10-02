module CustomSearch.Types.Autocomplete exposing (..)

--enableAutoComplete : Bool


type Type
    = Any
    | Ordered
    | Prefix


type Autocomplete
    = MatchType Type
    | MaxCompletions Int
    | MaxPromotions Int
    | ValidLanguages String
