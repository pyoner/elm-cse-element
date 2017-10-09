module CustomSearch.Codec exposing (..)

import Json.Decode as Decode
import Json.Bidirectional as Json
import CustomSearch.Attributes exposing (..)


--Helpers


encodeString : String -> Json.Value
encodeString =
    Json.encodeValue Json.string


encodeBool : Bool -> Json.Value
encodeBool =
    Json.encodeValue Json.bool


encodeInt : Int -> Json.Value
encodeInt =
    Json.encodeValue Json.int



--MatchType


matchTypeToString : MatchType -> String
matchTypeToString matchType =
    case matchType of
        Any ->
            "any"

        Ordered ->
            "ordered"

        Prefix ->
            "prefix"


matchTypeToValue : MatchType -> Json.Value
matchTypeToValue v =
    encodeString (matchTypeToString v)


valueToMatchType : Decode.Decoder MatchType
valueToMatchType =
    Decode.string
        |> Decode.andThen
            (\v ->
                case v of
                    "any" ->
                        Decode.succeed Any

                    "ordered" ->
                        Decode.succeed Ordered

                    "Prefix" ->
                        Decode.succeed Prefix

                    _ ->
                        Decode.fail <| "Bad MatchType value: " ++ v
            )


matchTypeCoder : Json.Coder MatchType
matchTypeCoder =
    Json.custom matchTypeToValue valueToMatchType



--Refinements


refStyleToString : RefStyle -> String
refStyleToString style =
    case style of
        Tab ->
            "tab"

        Link ->
            "link"


refStyleToValue : RefStyle -> Json.Value
refStyleToValue v =
    encodeString (refStyleToString v)


valueToRefStyle : Decode.Decoder RefStyle
valueToRefStyle =
    Decode.string
        |> Decode.andThen
            (\v ->
                case v of
                    "tab" ->
                        Decode.succeed Tab

                    "link" ->
                        Decode.succeed Link

                    _ ->
                        Decode.fail <| "Bad RefStyle value: " ++ v
            )


refStyleCoder : Json.Coder RefStyle
refStyleCoder =
    Json.custom refStyleToValue valueToRefStyle



--ImageLayout


imageLayoutToString : ImageLayout -> String
imageLayoutToString layout =
    case layout of
        Classic ->
            "classic"

        Column ->
            "column"

        Popup ->
            "popup"


imageLayoutToValue : ImageLayout -> Json.Value
imageLayoutToValue v =
    encodeString (imageLayoutToString v)


valueToImageLayout : Decode.Decoder ImageLayout
valueToImageLayout =
    Decode.string
        |> Decode.andThen
            (\v ->
                case v of
                    "classic" ->
                        Decode.succeed Classic

                    "column" ->
                        Decode.succeed Column

                    "popup" ->
                        Decode.succeed Popup

                    _ ->
                        Decode.fail <| "Bad ImageLayout value: " ++ v
            )


imageLayoutCoder : Json.Coder ImageLayout
imageLayoutCoder =
    Json.custom imageLayoutToValue valueToImageLayout



--Size


sizeToValue : Size -> Json.Value
sizeToValue size =
    case size of
        Large ->
            encodeString "large"

        Small ->
            encodeString "small"

        FilteredCSE ->
            encodeString "filtered_cse"

        SizeInt v ->
            encodeInt v


valueToSize : Decode.Decoder Size
valueToSize =
    let
        str =
            Decode.string
                |> Decode.andThen
                    (\v ->
                        case v of
                            "large" ->
                                Decode.succeed Large

                            "small" ->
                                Decode.succeed Small

                            "filtered_cse" ->
                                Decode.succeed FilteredCSE

                            _ ->
                                Decode.fail <| "Bad Size value: " ++ v
                    )

        int =
            Decode.map (\v -> SizeInt v) Decode.int
    in
        Decode.oneOf [ str, int ]


sizeCoder : Json.Coder Size
sizeCoder =
    Json.custom sizeToValue valueToSize



--Safe


safeToString : Safe -> String
safeToString safe =
    case safe of
        Moderate ->
            "moderate"

        Off ->
            "off"

        Active ->
            "active"


safeToValue : Safe -> Json.Value
safeToValue v =
    encodeString (safeToString v)


valueToSafe : Decode.Decoder Safe
valueToSafe =
    Decode.string
        |> Decode.andThen
            (\v ->
                case v of
                    "moderate" ->
                        Decode.succeed Moderate

                    "off" ->
                        Decode.succeed Off

                    "active" ->
                        Decode.succeed Active

                    _ ->
                        Decode.fail <| "Bad Safe value: " ++ v
            )


safeCoder : Json.Coder Safe
safeCoder =
    Json.custom safeToValue valueToSafe



--Attribute


attributeToPair : Attribute -> ( String, Json.Value )
attributeToPair attr =
    case attr of
        Gname v ->
            ( "gname", encodeString v )

        AutoSearchOnLoad v ->
            ( "autoSearchOnLoad", encodeBool v )

        EnableHistory v ->
            ( "enableHistory", encodeBool v )

        NewWindow v ->
            ( "newWindow", encodeBool v )

        QueryParameterName v ->
            ( "queryParameterName", encodeString v )

        ResultsUrl v ->
            ( "resultsUrl", encodeString v )

        --AutoComplete
        AutoCompleteMatchType matchType ->
            ( "autoCompleteMatchType"
            , encodeString
                (matchTypeToString matchType)
            )

        AutoCompleteMaxCompletions v ->
            ( "autoCompleteMaxCompletions", encodeInt v )

        AutoCompleteMaxPromotions v ->
            ( "autoCompleteMaxPromotions", encodeInt v )

        AutoCompleteValidLanguages v ->
            ( "autoCompleteValidLanguages", encodeString v )

        --Refinements
        DefaultToRefinement v ->
            ( "defaultToRefinement", encodeString v )

        RefinementStyle style ->
            ( "refinementStyle"
            , encodeString
                (refStyleToString style)
            )

        --ImageSearch
        EnableImageSearch v ->
            ( "enableImageSearch", encodeBool v )

        DefaultToImageSearch v ->
            ( "defaultToImageSearch", encodeBool v )

        ImageSearchResultSetSize size ->
            ( "imageSearchResultSetSize", sizeToValue size )

        ImageSearchLayout layout ->
            ( "imageSearchLayout"
            , encodeString
                (imageLayoutToString layout)
            )

        ImageCR v ->
            ( "image_cr", encodeString v )

        ImageGL v ->
            ( "image_gl", encodeString v )

        ImageAsSiteSearch v ->
            ( "image_as_sitesearch", encodeString v )

        ImageAsOQ v ->
            ( "image_as_oq", encodeString v )

        ImageSortBy v ->
            ( "image_sort_by", encodeString v )

        ImageFilter v ->
            ( "image_filter", encodeString v )

        -- WebSearch
        DisableWebSearch v ->
            ( "disableWebSearch", encodeBool v )

        WebSearchResultSetSize size ->
            ( "webSearchResultSetSize", sizeToValue size )

        WebSearchSafesearch safe ->
            ( "webSearchSafesearch"
            , encodeString
                (safeToString safe)
            )

        WebSearchQueryAddition v ->
            ( "webSearchQueryAddition", encodeString v )

        WebCR v ->
            ( "cr", encodeString v )

        WebGL v ->
            ( "gl", encodeString v )

        WebAsSiteSearch v ->
            ( "as_sitesearch", encodeString v )

        WebAsOQ v ->
            ( "as_oq", encodeString v )

        WebSortBy v ->
            ( "sort_by", encodeString v )

        WebFilter v ->
            ( "filter", encodeString v )

        -- SearchResults
        EnableOrderBy v ->
            ( "enableOrderBy", encodeBool v )

        LinkTarget v ->
            ( "linkTarget", encodeString v )

        NoResultsString v ->
            ( "noResultsString", encodeString v )

        ResultSetSize size ->
            ( "resultSetSize", sizeToValue size )

        SafeSearch safe ->
            ( "safeSearch"
            , encodeString
                (safeToString safe)
            )

        -- Ads
        AdClient v ->
            ( "adClient", encodeString v )

        AdEnableTest v ->
            ( "adEnableTest", encodeBool v )

        AdChannel v ->
            ( "adChannel", encodeString v )

        -- Google Analytics
        GaCategoryParameter v ->
            ( "gaCategoryParameter", encodeString v )

        GaQueryParameter v ->
            ( "gaQueryParameter", encodeString v )


{-| Convert Attributes to JSON object
-}
attributesToValue : Attributes -> Json.Value
attributesToValue attrs =
    List.map attributeToPair attrs
        |> Json.encodeValue (Json.keyValuePairs Json.value)


valueToPairs : Decode.Decoder (List ( String, Json.Value ))
valueToPairs =
    Decode.keyValuePairs Decode.value


decoderByKey : String -> Decode.Decoder Attribute
decoderByKey k =
    case k of
        "gname" ->
            Decode.map Gname Decode.string

        "autoSearchOnLoad" ->
            Decode.map AutoSearchOnLoad Decode.bool

        "enableHistory" ->
            Decode.map EnableHistory Decode.bool

        "newWindow" ->
            Decode.map NewWindow Decode.bool

        "queryParameterName" ->
            Decode.map QueryParameterName Decode.string

        "resultsUrl" ->
            Decode.map ResultsUrl Decode.string

        --AutoComplete
        "autoCompleteMatchType" ->
            Decode.map AutoCompleteMatchType valueToMatchType

        "autoCompleteMaxCompletions" ->
            Decode.map AutoCompleteMaxCompletions Decode.int

        "autoCompleteMaxPromotions" ->
            Decode.map AutoCompleteMaxPromotions Decode.int

        "autoCompleteValidLanguages" ->
            Decode.map AutoCompleteValidLanguages Decode.string

        --Refinements
        "defaultToRefinement" ->
            Decode.map DefaultToRefinement Decode.string

        "refinementStyle" ->
            Decode.map RefinementStyle valueToRefStyle

        --ImageSearch
        "enableImageSearch" ->
            Decode.map EnableImageSearch Decode.bool

        "defaultToImageSearch" ->
            Decode.map DefaultToImageSearch Decode.bool

        "imageSearchResultSetSize" ->
            Decode.map ImageSearchResultSetSize valueToSize

        "imageSearchLayout" ->
            Decode.map ImageSearchLayout valueToImageLayout

        "image_cr" ->
            Decode.map ImageCR Decode.string

        "image_gl" ->
            Decode.map ImageGL Decode.string

        "image_as_sitesearch" ->
            Decode.map ImageAsSiteSearch Decode.string

        "image_as_oq" ->
            Decode.map ImageAsOQ Decode.string

        "image_sort_by" ->
            Decode.map ImageSortBy Decode.string

        "image_filter" ->
            Decode.map ImageFilter Decode.string

        --WebSearch
        "disableWebSearch" ->
            Decode.map DisableWebSearch Decode.bool

        "webSearchResultSetSize" ->
            Decode.map WebSearchResultSetSize valueToSize

        "webSearchSafesearch" ->
            Decode.map WebSearchSafesearch valueToSafe

        "webSearchQueryAddition" ->
            Decode.map WebSearchQueryAddition Decode.string

        "cr" ->
            Decode.map WebCR Decode.string

        "gl" ->
            Decode.map WebGL Decode.string

        "as_sitesearch" ->
            Decode.map WebAsSiteSearch Decode.string

        "as_oq" ->
            Decode.map WebAsOQ Decode.string

        "sort_by" ->
            Decode.map WebSortBy Decode.string

        "filter" ->
            Decode.map WebFilter Decode.string

        --SearchResults
        "EnableOrderBy" ->
            Decode.map EnableOrderBy Decode.bool

        "linkTarget" ->
            Decode.map LinkTarget Decode.string

        "noResultsString" ->
            Decode.map NoResultsString Decode.string

        "resultSetSize" ->
            Decode.map ResultSetSize valueToSize

        "safeSearch" ->
            Decode.map SafeSearch valueToSafe

        --Ads
        "adClient" ->
            Decode.map AdClient Decode.string

        "adEnableTest" ->
            Decode.map AdEnableTest Decode.bool

        "adChannel" ->
            Decode.map AdChannel Decode.string

        --Google Analytics
        "gaCategoryParameter" ->
            Decode.map GaCategoryParameter Decode.string

        "gaQueryParameter" ->
            Decode.map GaQueryParameter Decode.string

        --fail
        _ ->
            Decode.fail <| "Bad key: " ++ k



--attributesCoder : Json.Coder Attributes
--attributesCoder =
--Json.list
