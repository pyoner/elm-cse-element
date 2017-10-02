module CustomSearch.Attributes.ImageSearch exposing (..)

import CustomSearch.Types.Common
    exposing
        ( SearchParameter(..)
        , Size
        )
import CustomSearch.Types.ImageSearch
    exposing
        ( ImageSearch(..)
        , ImageLayout(..)
        )
import CustomSearch.Attributes.Types exposing (Attribute(AttrImageSearch))


resultSetSize : Size -> Attribute
resultSetSize size =
    AttrImageSearch (ResultSetSize size)



--layout helpers


layout : ImageLayout -> Attribute
layout v =
    AttrImageSearch (Layout v)


layoutClassic : Attribute
layoutClassic =
    layout Classic


layoutColumn : Attribute
layoutColumn =
    layout Column


layoutPopup : Attribute
layoutPopup =
    layout Popup



--SearchParameter helpers


searchParameter : SearchParameter -> Attribute
searchParameter v =
    AttrImageSearch (SearchParameter v)


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
