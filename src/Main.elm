module Main exposing (..)

import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (src, attribute, disabled)
import Html.Events exposing (onClick)
import Element


---- MODEL ----


cseId : Element.Cx
cseId =
    "010757224930445905488:hydkhs9fcca"


cseElementId : String
cseElementId =
    "search-cse"


type alias Model =
    { cseReady : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { cseReady = False }, Cmd.none )



---- UPDATE ----


type Msg
    = CseInit Element.Cx
    | CseReady Bool
    | CseRender String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CseInit id ->
            ( model, Element.init id )

        CseReady flag ->
            ( { model | cseReady = flag }, Cmd.none )

        CseRender elementId ->
            ( model
            , Element.render
                ( { div = elementId
                  , tag = "search"
                  , gname = "test"
                  , attributes = Nothing
                  }
                , Nothing
                )
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick (CseInit cseId)
            , disabled model.cseReady
            ]
            [ text "init CSE" ]
        , button
            [ onClick (CseRender cseElementId)
            , disabled (not model.cseReady)
            ]
            [ text "render CSE" ]
        , div [ attribute "id" cseElementId ] []
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.cseReady == False then
        Element.ready CseReady
    else
        Sub.none



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
