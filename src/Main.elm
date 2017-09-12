module Main exposing (..)

import Html exposing (Html, text, div, img, button, select, option)
import Html.Attributes
    exposing
        ( src
        , attribute
        , disabled
        , selected
        , id
        , value
        )
import Html.Events exposing (onClick, on, targetValue)
import Json.Decode as Decode
import Process
import Task


--local import

import Element
import Types
import Attributes.Types as ATypes exposing (general, attributes)


---- MODEL ----


cseId : Types.Cx
cseId =
    "010757224930445905488:hydkhs9fcca"


cseElementId : String
cseElementId =
    "search-cse"


cseOptElementId : String
cseOptElementId =
    "search-cse-opt"


cseGname : ATypes.Gname
cseGname =
    "test"


type alias Item =
    ( Types.Component, ATypes.Attributes, String )


type alias Items =
    List Item


type alias Model =
    { cseIsReady : Bool
    , cseIsRendred : Bool
    , createContainer : Bool
    , selected : ATypes.Gname
    , items : Items
    }


init : ( Model, Cmd Msg )
init =
    ( { cseIsReady = False
      , cseIsRendred = False
      , createContainer = True
      , selected = "search"
      , items =
            [ ( Types.Search cseElementId
              , { attributes
                    | general =
                        { general | gname = "search" }
                }
              , "Search component"
              )
            , ( Types.SearchBoxResults ( cseElementId, cseOptElementId )
              , { attributes
                    | general =
                        { general | gname = "searchBoxResults" }
                }
              , "Search box and results component"
              )
            , ( Types.SearchBoxOnly cseElementId
              , { attributes
                    | general =
                        { general | gname = "searchBoxOnly" }
                }
              , "Search box only component"
              )
            , ( Types.SearchResultsOnly cseOptElementId
              , { attributes
                    | general =
                        { general | gname = "searchResultsOnly" }
                }
              , "Search results only component"
              )
            ]
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = CseLoad Types.Cx
    | CseReady Bool
    | CseRender
    | ElementEvent Types.Event
    | GnameSelected ATypes.Gname
    | CreateContainer Bool


getSelectedItem : ATypes.Gname -> Items -> Maybe Item
getSelectedItem gname items =
    case List.head items of
        Nothing ->
            Nothing

        Just ( component, attrs, description ) ->
            if attrs.general.gname == gname then
                Just ( component, attrs, description )
            else
                case List.tail items of
                    Nothing ->
                        Nothing

                    Just tail ->
                        getSelectedItem gname tail


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CseLoad id ->
            ( model, Element.load id )

        CseReady flag ->
            ( { model | cseIsReady = flag }, Cmd.none )

        CseRender ->
            let
                item =
                    getSelectedItem model.selected model.items
            in
                case item of
                    Nothing ->
                        ( model
                        , Cmd.none
                        )

                    Just ( component, attts, description ) ->
                        ( model, Element.render component attts )

        GnameSelected gname ->
            ( { model | selected = gname, createContainer = False }
            , Process.sleep 0 |> Task.andThen (\_ -> Task.succeed True) |> Task.perform CreateContainer
            )

        CreateContainer flag ->
            ( { model | createContainer = flag }, Cmd.none )

        -- Element events
        ElementEvent event ->
            case (Debug.log "ElementEvent" event) of
                Types.Load result ->
                    case result of
                        Ok cx ->
                            ( { model | cseIsReady = True }, Cmd.none )

                        Err err ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )



---- VIEW ----


containerView : Model -> Html Msg
containerView model =
    div [] <|
        if model.createContainer then
            [ div [ id cseElementId ] []
            , div [ id cseOptElementId ] []
            ]
        else
            []


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick (CseLoad cseId)
            , disabled model.cseIsReady
            ]
            [ text "load CSE" ]
        , select
            [ disabled (not model.cseIsReady)
            , on "change" (Decode.map GnameSelected targetValue)
            ]
          <|
            List.map
                (\( component, attrs, description ) ->
                    option
                        [ value attrs.general.gname
                        , selected (model.selected == attrs.general.gname)
                        ]
                        [ text
                            description
                        ]
                )
                model.items
        , button
            [ onClick CseRender
            , disabled
                (not model.cseIsReady
                    || model.cseIsRendred
                )
            ]
            [ text "render" ]
        , containerView model
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Element.listen ElementEvent



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
