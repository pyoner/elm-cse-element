module CustomSearch.Attributes.General exposing (..)

import CustomSearch.Types.Common exposing (Gname)
import CustomSearch.Types.General exposing (General(..))
import CustomSearch.Attributes.Types exposing (Attribute(AttrGeneral))


gname : String -> Attribute
gname name =
    AttrGeneral (Gname name)


autoSearchOnLoad : Bool -> Attribute
autoSearchOnLoad flag =
    AttrGeneral (AutoSearchOnLoad flag)


enableHistory : Bool -> Attribute
enableHistory flag =
    AttrGeneral (EnableHistory flag)


newWindow : Bool -> Attribute
newWindow flag =
    AttrGeneral (NewWindow flag)


queryParameterName : String -> Attribute
queryParameterName name =
    AttrGeneral (QueryParameterName name)


resultsUrl : String -> Attribute
resultsUrl url =
    AttrGeneral (ResultsUrl url)
