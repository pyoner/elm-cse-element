module Decode exposing (decoder)

import Json.Decode exposing (..)
import Types exposing (..)


--Union Type decoders


makeErrDecoder : (Result String b -> Event) -> Decoder Event
makeErrDecoder tagger =
    map
        (\err -> tagger (Err err))
        string


loadDecoders : ( Decoder Event, Decoder Event )
loadDecoders =
    ( map
        (\cx -> Load (Ok cx))
        string
    , makeErrDecoder Load
    )


rendeDecoders : ( Decoder Event, Decoder Event )
rendeDecoders =
    ( map
        (\gname -> Render (Ok gname))
        string
    , makeErrDecoder Render
    )


executeDecoders : ( Decoder Event, Decoder Event )
executeDecoders =
    ( map
        (\pair -> Execute (Ok pair))
        (map2
            (\gname query -> ( gname, query ))
            (index 0 string)
            (index 1 string)
        )
    , makeErrDecoder Execute
    )


prefillQueryDecoders : ( Decoder Event, Decoder Event )
prefillQueryDecoders =
    ( map
        (\pair -> PrefillQuery (Ok pair))
        (map2
            (\gname query -> ( gname, query ))
            (index 0 string)
            (index 1 string)
        )
    , makeErrDecoder PrefillQuery
    )


inputQueryDecoders : ( Decoder Event, Decoder Event )
inputQueryDecoders =
    ( map
        (\pair -> InputQuery (Ok pair))
        (map2
            (\gname query -> ( gname, query ))
            (index 0 string)
            (index 1 string)
        )
    , makeErrDecoder InputQuery
    )



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
