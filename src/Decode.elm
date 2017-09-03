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



--Top level decoders


selectDecoder : Bool -> ( Decoder Event, Decoder Event ) -> Decoder Event
selectDecoder flag ( okDecoder, errDecoder ) =
    if flag then
        okDecoder
    else
        errDecoder


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
                        (index 2
                            (selectDecoder flag loadDecoders)
                        )

                    _ ->
                        fail <|
                            "Bad event name: "
                                ++ event
            )
