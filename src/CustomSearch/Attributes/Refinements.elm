module CustomSearch.Attributes.Refinements exposing (..)

import CustomSearch.Types.Refinements
    exposing
        ( Refinements(..)
        , RefinementStyle(..)
        )
import CustomSearch.Attributes.Types exposing (Attribute(AttrRefinements))


default : String -> Attribute
default v =
    AttrRefinements (Default v)


style : RefinementStyle -> Attribute
style v =
    AttrRefinements (Style v)



--style helper


styleTab : Attribute
styleTab =
    AttrRefinements (Style Tab)


styleLink : Attribute
styleLink =
    AttrRefinements (Style Link)
