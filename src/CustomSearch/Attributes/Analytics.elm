module CustomSearch.Attributes.Analytics exposing (..)

import CustomSearch.Types.Analytics as Analytics
import CustomSearch.Attributes.Types exposing (Attribute(AttrAnalytics))


categoryParameter : String -> Attribute
categoryParameter v =
    AttrAnalytics (Analytics.CategoryParameter v)


queryParameter : String -> Attribute
queryParameter v =
    AttrAnalytics (Analytics.QueryParameter v)
