module Encode exposing (..)

import Json.Encode exposing (..)
import Types
    exposing
        ( Attributes
        , Analytics
        , Ads
        , SearchResults
        , Size(..)
        , SafeSearch(..)
        , WebSearch
        )


--encoder : Attributes -> Value


maybeEncoder :
    Maybe a
    -> String
    -> (a -> Value)
    -> List ( String, Value )
maybeEncoder a name encode =
    case a of
        Nothing ->
            []

        Just v ->
            [ ( name, encode v ) ]


analyticsEncoder : Analytics -> List ( String, Value )
analyticsEncoder analytics =
    (maybeEncoder
        analytics.categoryParameter
        "gaCategoryParameter"
        string
    )
        ++ (maybeEncoder
                analytics.queryParameter
                "gaQueryParameter"
                string
           )


adsEncoder : Ads -> List ( String, Value )
adsEncoder ads =
    [ ( "adclient", string ads.client )
    , ( "adtest"
      , string
            (if ads.enableTest then
                "on"
             else
                "off"
            )
      )
    ]
        ++ (maybeEncoder ads.channel "adchannel" string)


sizeEncoder : Size -> Value
sizeEncoder size =
    case size of
        SizeInt v ->
            int v

        SizeString v ->
            string v


safeSearchEncoder : SafeSearch -> Value
safeSearchEncoder safeSearch =
    case safeSearch of
        Moderate ->
            string "moderate"

        Off ->
            string "off"

        Active ->
            string "active"


searchResultsEncoder : SearchResults -> List ( String, Value )
searchResultsEncoder r =
    [ ( "enableOrderBy", bool r.enableOrderBy )
    , ( "resultSetSize", sizeEncoder r.setSize )
    , ( "safeSearch", safeSearchEncoder r.safeSearch )
    ]
        ++ (maybeEncoder r.linkTarget "linkTarget" string)
        ++ (maybeEncoder r.noResultsString "noResultsString" string)


webSearchEncoder : WebSearch -> List ( String, Value )
webSearchEncoder r =
    [ ( "webSearchResultSetSize", sizeEncoder r.resultSetSize )
    , ( "webSearchSafesearch", safeSearchEncoder r.safeSearch )
    ]
        ++ (maybeEncoder r.queryAddition "webSearchQueryAddition" string)
        ++ (maybeEncoder r.cr "cr" string)
        ++ (maybeEncoder r.gl "gl" string)
        ++ (maybeEncoder r.as_sitesearch "as_sitesearch" string)
        ++ (maybeEncoder r.as_oq "as_oq" string)
        ++ (maybeEncoder r.sort_by "sort_by" string)
        ++ (maybeEncoder r.filter "filter" string)
