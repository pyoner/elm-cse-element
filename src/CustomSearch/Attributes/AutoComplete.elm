module CustomSearch.Attributes.Autocomplete exposing (..)

import CustomSearch.Types.Autocomplete
    exposing
        ( Autocomplete(..)
        , Type(..)
        )
import CustomSearch.Attributes.Types exposing (Attribute(AttrAutocomplete))


maxCompletions : Int -> Attribute
maxCompletions v =
    AttrAutocomplete (MaxCompletions v)


maxPromotions : Int -> Attribute
maxPromotions v =
    AttrAutocomplete (MaxPromotions v)


validLanguages : String -> Attribute
validLanguages v =
    AttrAutocomplete (ValidLanguages v)


matchType : Type -> Attribute
matchType type_ =
    AttrAutocomplete (MatchType type_)



--matchType helpers


matchTypeAny : Attribute
matchTypeAny =
    AttrAutocomplete (MatchType Any)


matchTypeOrdered : Attribute
matchTypeOrdered =
    AttrAutocomplete (MatchType Ordered)


matchTypePrefix : Attribute
matchTypePrefix =
    AttrAutocomplete (MatchType Prefix)
