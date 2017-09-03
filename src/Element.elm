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


{-| Load a CSE script
-}
port load : Cx -> Cmd msg


{-| Renders a CSE element
-}
port render : ( Config, Maybe Config ) -> Cmd msg


{-| Renders all CSE tags/classes in the specified container
-}
port go : String -> Cmd msg


{-| Gets the element object by gname
-}
port getElement : String -> Cmd msg


{-| Executes a programmatic query
-}
port execute : ( Gname, Query ) -> Cmd msg


{-| Prefills the searchbox with a query string without executing the query
-}
port prefillQuery : ( Gname, Query ) -> Cmd msg


{-| Gets the current value displayed in the input box
-}
port getInputQuery : Gname -> Cmd msg


{-| Clears the control by hiding everything but the search box, if any
-}
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
