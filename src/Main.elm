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


cseGname : Element.Gname
cseGname =
    "test"


type alias Model =
    { cseIsReady : Bool
    , cseIsRendred : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { cseIsReady = False, cseIsRendred = False }, Cmd.none )



---- UPDATE ----


type Msg
    = CseInit Element.Cx
    | CseReady Bool
    | CseRender Element.Gname String
    | CseClearResults Element.Gname
    | CsePrefillQuery Element.Gname Element.Query
    | CseExecute Element.Gname Element.Query


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CseInit id ->
            ( model, Element.init id )

        CseReady flag ->
            ( { model | cseIsReady = flag }, Cmd.none )

        CseRender gname elementId ->
            ( { model | cseIsRendred = True }
            , Element.render
                ( { div = elementId
                  , tag = "search"
                  , gname = gname
                  , attributes = Nothing
                  }
                , Nothing
                )
            )

        CseClearResults gname ->
            ( model, Element.clearAllResults gname )

        CsePrefillQuery gname query ->
            ( model, Element.prefillQuery ( gname, query ) )

        CseExecute gname query ->
            ( model, Element.execute ( gname, query ) )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick (CseInit cseId)
            , disabled model.cseIsReady
            ]
            [ text "init CSE" ]
        , button
            [ onClick (CseRender cseGname cseElementId)
            , disabled (not model.cseIsReady || model.cseIsRendred)
            ]
            [ text "render CSE" ]
        , button
            [ onClick (CseClearResults cseGname)
            , disabled (not model.cseIsRendred)
            ]
            [ text "clear search results" ]
        , button
            [ onClick (CsePrefillQuery cseGname "elm-lang")
            , disabled (not model.cseIsRendred)
            ]
            [ text "prefill query" ]
        , button
            [ onClick (CseExecute cseGname "ethereum")
            , disabled (not model.cseIsRendred)
            ]
            [ text "execute query" ]
        , div [ attribute "id" cseElementId ] []
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.cseIsReady == False then
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
