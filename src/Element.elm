port module Element
    exposing
        ( init
        , ready
        , render
        , go
        , getElement
        , aboutElement
        , execute
        , prefillQuery
        , getInputQuery
        , inputQuery
        , clearAllResults
        )

import Types exposing (..)
import Json.Decode as Decode


port init : Cx -> Cmd msg


port ready : (Bool -> msg) -> Sub msg


port event : (Decode.Value -> msg) -> Sub msg


port render : ( Config, Maybe Config ) -> Cmd msg


port go : String -> Cmd msg


port getElement : String -> Cmd msg


port aboutElement : (Element -> msg) -> Sub msg


port execute : ( Gname, Query ) -> Cmd msg


port prefillQuery : ( Gname, Query ) -> Cmd msg


port getInputQuery : Gname -> Cmd msg


port inputQuery : (( Gname, Query ) -> msg) -> Sub msg


port clearAllResults : Gname -> Cmd msg
