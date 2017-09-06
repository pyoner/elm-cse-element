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
        , ImageSearch
        , Layout(..)
        , Refinements
        , RefinementStyle(..)
        , Autocomplete
        , MatchType(..)
        , General
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


layoutEncoder : Layout -> Value
layoutEncoder layout =
    case layout of
        Classic ->
            string "classic"

        Column ->
            string "column"

        Popup ->
            string "popup"


imageSearchEncoder : ImageSearch -> List ( String, Value )
imageSearchEncoder r =
    [ ( "imageSearchResultSetSize", sizeEncoder r.resultSetSize ) ]
        ++ (maybeEncoder r.layout "imageSearchLayout" layoutEncoder)
        ++ (maybeEncoder r.cr "image_cr" string)
        ++ (maybeEncoder r.gl "image_gl" string)
        ++ (maybeEncoder r.as_sitesearch "image_as_sitesearch" string)
        ++ (maybeEncoder r.as_oq "image_as_oq" string)
        ++ (maybeEncoder r.sort_by "image_sort_by" string)
        ++ (maybeEncoder r.filter "image_filter" string)


refinementStyleEncoder : RefinementStyle -> Value
refinementStyleEncoder style =
    case style of
        Tab ->
            string "tab"

        Link ->
            string "link"


refinementsEncoder : Refinements -> List ( String, Value )
refinementsEncoder r =
    (maybeEncoder r.default "defaultToRefinement" string)
        ++ (maybeEncoder r.style "refinementStyle" refinementStyleEncoder)


matchTypeEncoder : MatchType -> Value
matchTypeEncoder matchType =
    case matchType of
        Any ->
            string "any"

        Ordered ->
            string "ordered"

        Prefix ->
            string "prefix"


autocompleteEncoder : Autocomplete -> List ( String, Value )
autocompleteEncoder r =
    (maybeEncoder r.matchType "autoCompleteMatchType" matchTypeEncoder)
        ++ (maybeEncoder r.maxCompletions "autoCompleteMaxCompletions" int)
        ++ (maybeEncoder r.maxPromotions "autoCompleteMaxPromotions" int)
        ++ (maybeEncoder r.validLanguages "autoCompleteValidLanguages" string)


generalEncoder : General -> List ( String, Value )
generalEncoder r =
    [ ( "gname", string r.gname )
    , ( "autoSearchOnLoad", bool r.autoSearchOnLoad )
    , ( "enableHistory", bool r.enableHistory )
    , ( "newWindow", bool r.newWindow )
    , ( "queryParameterName", string r.queryParameterName )
    ]
        ++ (maybeEncoder r.resultsUrl "resultsUrl" string)
