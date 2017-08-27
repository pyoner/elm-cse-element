module Main exposing (..)

import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (src, attribute)
import Html.Events exposing (onClick)
import Element


---- MODEL ----


cseId : Element.Cx
cseId =
    "010757224930445905488:hydkhs9fcca"


type alias Model =
    { cseId : String }


init : ( Model, Cmd Msg )
init =
    ( { cseId = "" }, Cmd.none )



---- UPDATE ----


type Msg
    = CseInit Element.Cx
    | CseReady Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CseInit id ->
            ( { model | cseId = id }, Element.init id )

        CseReady flag ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div [] [ text "Your Elm App is working!" ]
        , button [ onClick (CseInit cseId) ] [ text "init CSE" ]
        , div [ attribute "id" "cse-search" ] []
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    if String.isEmpty model.cseId then
        Sub.none
    else
        Element.ready CseReady



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
