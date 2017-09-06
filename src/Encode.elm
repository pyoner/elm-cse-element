module Encode exposing (..)

import Json.Encode exposing (..)
import Types exposing (Attributes, Analytics)


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
