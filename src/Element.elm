port module Element
    exposing
        ( load
        , listen
        , render
        , go
        , getElement
        , aboutElement
        , execute
        , prefillQuery
        , getInputQuery
        , clearAllResults
        )

import Types exposing (..)
import Decode exposing (decoder)
import Json.Decode as Decode


port load : Cx -> Cmd msg


port render : ( Config, Maybe Config ) -> Cmd msg


port go : String -> Cmd msg


port getElement : String -> Cmd msg


port aboutElement : (Element -> msg) -> Sub msg


port execute : ( Gname, Query ) -> Cmd msg


port prefillQuery : ( Gname, Query ) -> Cmd msg


port getInputQuery : Gname -> Cmd msg


port clearAllResults : Gname -> Cmd msg



-- Subscriptions


port event : (Decode.Value -> msg) -> Sub msg


listen : (Event -> msg) -> Sub msg
listen tagger =
    event
        (\v ->
            tagger <|
                case (Decode.decodeValue decoder v) of
                    Ok event ->
                        event

                    Err err ->
                        DecodeError err
        )
