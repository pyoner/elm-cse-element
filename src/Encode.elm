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
