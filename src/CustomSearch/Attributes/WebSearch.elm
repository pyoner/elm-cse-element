module CustomSearch.Attributes.WebSearch exposing (..)

import CustomSearch.Types.Common
    exposing
        ( SafeSearch(..)
        , SearchParameter(..)
        , Size
        )
import CustomSearch.Types.WebSearch as WebSearch
import CustomSearch.Attributes.Types exposing (Attribute(AttrWebSearch))


--SafeSearch helpers


safeSearch : SafeSearch -> Attribute
safeSearch v =
    AttrWebSearch (WebSearch.SafeSearch v)


safeSearchModerate : Attribute
safeSearchModerate =
    safeSearch Moderate


safeSearchOff : Attribute
safeSearchOff =
    safeSearch Off


safeSearchActive : Attribute
safeSearchActive =
    safeSearch Active



--queryAddition


queryAddition : String -> Attribute
queryAddition v =
    AttrWebSearch (WebSearch.QueryAddition v)



--results size


resultSetSize : Size -> Attribute
resultSetSize size =
    AttrWebSearch (WebSearch.ResultSetSize size)



--SearchParameter helpers


searchParameter : SearchParameter -> Attribute
searchParameter v =
    AttrWebSearch (WebSearch.SearchParameter v)


countryRestrics : String -> Attribute
countryRestrics v =
    searchParameter (CountryRestricts v)


geoLocation : String -> Attribute
geoLocation v =
    searchParameter (GeoLocation v)


asSiteSearch : String -> Attribute
asSiteSearch v =
    searchParameter (AsSiteSearch v)


asOrQuery : String -> Attribute
asOrQuery v =
    searchParameter (AsOrQuery v)


sortBy : String -> Attribute
sortBy v =
    searchParameter (SortBy v)


filter : String -> Attribute
filter v =
    searchParameter (Filter v)
