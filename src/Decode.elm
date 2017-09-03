module Decode exposing (decoder)

import Json.Decode exposing (..)
import Types exposing (..)


-- helpers decoders


makeErrDecoder : (Result String b -> Event) -> Decoder Event
makeErrDecoder tagger =
    map
        (\err -> tagger (Err err))
        string


makeQueryResultDecoders : (QueryResult -> Event) -> ( Decoder Event, Decoder Event )
makeQueryResultDecoders tagger =
    ( map
        (\pair -> tagger (Ok pair))
        (map2
            (\gname query -> ( gname, query ))
            (index 0 string)
            (index 1 string)
        )
    , makeErrDecoder tagger
    )


makeGnameResultDecoders : (GnameResult -> Event) -> ( Decoder Event, Decoder Event )
makeGnameResultDecoders tagger =
    ( map
        (\gname -> tagger (Ok gname))
        string
    , makeErrDecoder tagger
    )



--Union Type decoders


loadDecoders : ( Decoder Event, Decoder Event )
loadDecoders =
    ( map
        (\cx -> Load (Ok cx))
        string
    , makeErrDecoder Load
    )



--GnameResult decoders


rendeDecoders : ( Decoder Event, Decoder Event )
rendeDecoders =
    makeGnameResultDecoders Render


clearAllResultsDecoders : ( Decoder Event, Decoder Event )
clearAllResultsDecoders =
    makeGnameResultDecoders ClearAllResults



--QueryResult decoders


executeDecoders : ( Decoder Event, Decoder Event )
executeDecoders =
    makeQueryResultDecoders Execute


prefillQueryDecoders : ( Decoder Event, Decoder Event )
prefillQueryDecoders =
    makeQueryResultDecoders PrefillQuery


inputQueryDecoders : ( Decoder Event, Decoder Event )
inputQueryDecoders =
    makeQueryResultDecoders InputQuery



--Top level decoders


selectDecoder : Bool -> ( Decoder Event, Decoder Event ) -> Decoder Event
selectDecoder flag ( okDecoder, errDecoder ) =
    if flag then
        okDecoder
    else
        errDecoder


valueDecoder : Bool -> ( Decoder Event, Decoder Event ) -> Decoder Event
valueDecoder flag decoders =
    selectDecoder flag decoders
        |> index 2


decoder : Decoder Event
decoder =
    (map2
        (\event flag -> ( event, flag ))
        (index 0 string)
        (index 1 bool)
    )
        |> andThen
            (\( event, flag ) ->
                case event of
                    "Load" ->
                        valueDecoder flag loadDecoders

                    "Render" ->
                        valueDecoder flag rendeDecoders

                    "Execute" ->
                        valueDecoder flag executeDecoders

                    "PrefillQuery" ->
                        valueDecoder flag prefillQueryDecoders

                    "InputQuery" ->
                        valueDecoder flag inputQueryDecoders

                    _ ->
                        fail <|
                            "Bad event name: "
                                ++ event
            )
