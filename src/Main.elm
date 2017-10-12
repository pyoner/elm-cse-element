module CustomSearch.Main exposing (..)

import Html exposing (Html, text, div, img, button, select, option, input)
import Html.Attributes
    exposing
        ( src
        , attribute
        , disabled
        , selected
        , id
        , value
        )
import Html.Events exposing (onInput, onClick, on, targetValue)
import Json.Decode as Decode


--local import

import CustomSearch.Element as Element
import CustomSearch.Types as Types
import CustomSearch.Attributes as Attributes


---- MODEL ----


cseId : Types.Cx
cseId =
    "010757224930445905488:hydkhs9fcca"


cseElementId : Types.ElementId
cseElementId =
    "search-cse"


cseOptElementId : Types.ElementId
cseOptElementId =
    "search-cse-opt"


cseGname : Types.Gname
cseGname =
    "test"


type alias Item =
    ( Types.Component, Attributes.Attributes, String )


type alias Items =
    List Item


type alias Model =
    { cseIsReady : Bool
    , cseIsRendred : Bool
    , selected : Types.Gname
    , items : Items
    , query : String
    }


init : ( Model, Cmd Msg )
init =
    ( { cseIsReady = False
      , cseIsRendred = False
      , selected = "search"
      , query = ""
      , items =
            [ ( Types.Search
                    "search"
                    cseElementId
              , []
              , "Search component"
              )
            , ( Types.SearchBoxResults
                    "searchBoxResults"
                    ( cseElementId, cseOptElementId )
              , []
              , "Search box and results component"
              )
            , ( Types.SearchBoxOnly
                    "searchBoxOnly"
                    cseElementId
              , []
              , "Search box only component"
              )
            , ( Types.SearchResultsOnly
                    "searchResultsOnly"
                    cseOptElementId
              , []
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
    | GnameSelected Types.Gname
    | Search
    | Query String
    | ClearAllResults


componentGetGname : Types.Component -> Types.Gname
componentGetGname component =
    case component of
        Types.Search a _ ->
            a

        Types.SearchBoxResults a _ ->
            a

        Types.SearchBoxOnly a _ ->
            a

        Types.SearchResultsOnly a _ ->
            a


getSelectedItem : Types.Gname -> Items -> Maybe Item
getSelectedItem gname items =
    case List.head items of
        Nothing ->
            Nothing

        Just ( component, attrs, description ) ->
            if componentGetGname component == gname then
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
            ( { model | selected = gname }
            , Cmd.batch
                [ Element.clear cseElementId
                , Element.clear cseOptElementId
                ]
            )

        -- Search box messages
        Query query ->
            ( { model | query = query }, Cmd.none )

        Search ->
            ( model, Element.execute ( model.selected, model.query ) )

        ClearAllResults ->
            ( model, Element.clearAllResults model.selected )

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
    let
        nodes =
            if model.selected == "searchResultsOnly" then
                [ searchBoxView model ]
            else
                []
    in
        div [] <|
            [ div [] nodes
            , div [ id cseElementId ] []
            , div [ id cseOptElementId ] []
            ]


searchBoxView : Model -> Html Msg
searchBoxView model =
    div []
        [ input [ onInput Query ] []
        , button [ onClick Search ] [ text "search" ]
        , button [ onClick ClearAllResults ] [ text "clear" ]
        ]


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
                    let
                        gname =
                            componentGetGname component
                    in
                        option
                            [ value gname
                            , selected (model.selected == gname)
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
