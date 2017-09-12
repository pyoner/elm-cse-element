module Encode exposing (componentEncoder)

import Json.Encode exposing (Value, string, null, object, list)
import Types exposing (Component(..), Config)
import Attributes.Types exposing (Attributes)
import Attributes.Encode exposing (attrsEncoder)


componentEncoder : Component -> Attributes -> Value
componentEncoder component attrs =
    let
        base =
            { attributes = attrs, tag = "", div = "" }

        ( config, optConfig ) =
            case component of
                Search id ->
                    ( { base | div = id, tag = "search" }, Nothing )

                SearchBoxResults ( id, optId ) ->
                    ( { base | div = id, tag = "searchbox" }
                    , Just { base | div = optId, tag = "searchresults" }
                    )

                SearchBoxOnly id ->
                    ( { base | div = id, tag = "searchbox-only" }, Nothing )

                SearchResultsOnly id ->
                    ( { base | div = id, tag = "searchresults-only" }, Nothing )
    in
        list <|
            [ configEncoder config ]
                ++ [ (case optConfig of
                        Just c ->
                            configEncoder c

                        Nothing ->
                            null
                     )
                   ]


configEncoder : Config -> Value
configEncoder { div, tag, attributes } =
    object
        [ ( "div", string div )
        , ( "tag", string tag )
        , ( "gname", string attributes.general.gname )
        , ( "attributes", attrsEncoder attributes )
        ]
