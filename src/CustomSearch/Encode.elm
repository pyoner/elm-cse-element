module CustomSearch.Encode exposing (componentEncoder)

import Json.Encode exposing (Value, string, null, object, list)
import Json.Bidirectional as Json
import CustomSearch.Types exposing (Component(..), Config)
import CustomSearch.Attributes exposing (Attributes)
import CustomSearch.Codec exposing (attributesCoder)


componentEncoder : Component -> Attributes -> Value
componentEncoder component attrs =
    let
        base =
            { attributes = attrs, gname = "", tag = "", div = "" }

        ( config, optConfig ) =
            case component of
                Search gname id ->
                    ( { base | gname = gname, div = id, tag = "search" }, Nothing )

                SearchBoxResults gname ( id, optId ) ->
                    ( { base | gname = gname, div = id, tag = "searchbox" }
                    , Just { base | div = optId, tag = "searchresults" }
                    )

                SearchBoxOnly gname id ->
                    ( { base | gname = gname, div = id, tag = "searchbox-only" }, Nothing )

                SearchResultsOnly gname id ->
                    ( { base | gname = gname, div = id, tag = "searchresults-only" }, Nothing )
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
        , ( "attributes", attributes |> Json.encodeValue attributesCoder )
        ]
