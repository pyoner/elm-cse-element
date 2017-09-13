port module Element
    exposing
        ( load
        , listen
        , render
        , go
        , getElement
        , execute
        , prefillQuery
        , getInputQuery
        , clearAllResults
        )

import Json.Decode as Decode
import Json.Encode as Encode


--local import

import Types
    exposing
        ( Cx
        , Query
        , Event(DecodeError)
        , ElementId
        , Component(..)
        )
import Attributes.Types exposing (Attributes, Gname)
import Decode exposing (decoder)
import Encode exposing (componentEncoder)


{-| Load a CSE script
-}
port load : Cx -> Cmd msg


port render_ : Encode.Value -> Cmd msg


{-| Renders a CSE element
-}
render : Component -> Attributes -> Cmd msg
render component attrs =
    render_ (componentEncoder component attrs)


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


{-| Clear dom by element id
-}
port clear : String -> Cmd msg



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
