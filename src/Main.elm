module Main exposing (..)

import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (src, attribute, disabled)
import Html.Events exposing (onClick)
import Element
import Types


---- MODEL ----


cseId : Types.Cx
cseId =
    "010757224930445905488:hydkhs9fcca"


cseElementId : String
cseElementId =
    "search-cse"


cseGname : Types.Gname
cseGname =
    "test"


type alias Model =
    { cseIsReady : Bool
    , cseIsRendred : Bool
    , cseContainerFlag : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { cseIsReady = False
      , cseIsRendred = False
      , cseContainerFlag = False
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = CseInit Types.Cx
    | CseReady Bool
    | CseRender Types.Gname String
    | CseClearResults Types.Gname
    | CsePrefillQuery Types.Gname Types.Query
    | CseExecute Types.Gname Types.Query
    | CseDestroyContainer
    | CseCreateContainer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CseInit id ->
            ( model, Element.init id )

        CseReady flag ->
            ( { model | cseIsReady = flag }, Cmd.none )

        CseRender gname elementId ->
            ( model
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

        --create/destroy container
        CseDestroyContainer ->
            ( { model | cseContainerFlag = False, cseIsRendred = False }, Cmd.none )

        CseCreateContainer ->
            ( { model | cseContainerFlag = True }, Cmd.none )



---- VIEW ----


containerView : String -> Model -> Html Msg
containerView id model =
    if not model.cseContainerFlag then
        text ""
    else
        div [ attribute "id" id ] []


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick (CseInit cseId)
            , disabled model.cseIsReady
            ]
            [ text "init CSE" ]
        , button
            [ onClick (CseCreateContainer)
            , disabled (not model.cseIsReady || model.cseContainerFlag)
            ]
            [ text "create container" ]
        , button
            [ onClick (CseRender cseGname cseElementId)
            , disabled
                (not model.cseIsReady
                    || model.cseIsRendred
                    || not model.cseContainerFlag
                )
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
        , button
            [ onClick (CseDestroyContainer)
            , disabled (not model.cseIsRendred)
            ]
            [ text "destroy container" ]
        , containerView cseElementId model
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
