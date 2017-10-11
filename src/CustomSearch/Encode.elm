module CustomSearch.Encode exposing (componentEncoder)

import Json.Encode exposing (Value, string, null, object, list)
import Json.Bidirectional as Json


--local

import CustomSearch.Types exposing (Component(..), Config)
import CustomSearch.Attributes exposing (Attributes, Attribute(Gname))
import CustomSearch.Codec exposing (attributesCoder)


componentEncoder : Component -> Attributes -> Value
componentEncoder component attrs =
    let
        base =
            { attributes = [], gname = "", tag = "", div = "" }

        ( gname, baseConfig, baseOptConfig ) =
            case component of
                Search gname id ->
                    ( gname, { base | div = id, tag = "search" }, Nothing )

                SearchBoxResults gname ( id, optId ) ->
                    ( gname
                    , { base | div = id, tag = "searchbox" }
                    , Just { base | div = optId, tag = "searchresults" }
                    )

                SearchBoxOnly gname id ->
                    ( gname, { base | div = id, tag = "searchbox-only" }, Nothing )

                SearchResultsOnly gname id ->
                    ( gname, { base | div = id, tag = "searchresults-only" }, Nothing )

        --add gname to config and optConfig
        attributes =
            attrs ++ [ Gname gname ]

        config =
            { baseConfig | gname = gname, attributes = attributes }

        optConfig =
            (case baseOptConfig of
                Just opt ->
                    Just { opt | gname = gname, attributes = attributes }

                Nothing ->
                    Nothing
            )
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
