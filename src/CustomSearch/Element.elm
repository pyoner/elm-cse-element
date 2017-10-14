module CustomSearch.Element
    exposing
        ( load
        , render
        , execute
        , prefillQuery
        , getInputQuery
        , clearAllResults
        , clear
        )

{-| Element
@docs load, render, execute, prefillQuery, getInputQuery, clearAllResults, clear
-}

import Task


--local import

import Native.Element
import CustomSearch.Types
    exposing
        ( Cx
        , Query
        , Gname
        , ElementId
        , Component(..)
        )
import CustomSearch.Attributes exposing (Attributes)
import CustomSearch.Encode exposing (componentEncoder)


{-| Load a CSE script
-}
load : (Result a b -> msg) -> Cx -> Cmd msg
load tagger cx =
    Task.attempt tagger <|
        Native.Element.load cx


{-| Renders a CSE element
-}
render : (Result a b -> msg) -> Component -> Attributes -> Cmd msg
render tagger component attrs =
    Task.attempt tagger <|
        Native.Element.render (componentEncoder component attrs)


{-| Executes a programmatic query
-}
execute : (Result a b -> msg) -> ( Gname, Query ) -> Cmd msg
execute tagger a =
    Task.attempt tagger <|
        Native.Element.execute a


{-| Prefills the searchbox with a query string without executing the query
-}
prefillQuery : (Result a b -> msg) -> ( Gname, Query ) -> Cmd msg
prefillQuery tagger a =
    Task.attempt tagger <|
        Native.Element.prefillQuery a


{-| Gets the current value displayed in the input box
-}
getInputQuery : (Result a b -> msg) -> Gname -> Cmd msg
getInputQuery tagger gname =
    Task.attempt tagger <|
        Native.Element.getInputQuery gname


{-| Clears the control by hiding everything but the search box, if any
-}
clearAllResults : (Result a b -> msg) -> Gname -> Cmd msg
clearAllResults tagger gname =
    Task.attempt tagger <|
        Native.Element.clearAllResults gname


{-| Clear dom by element id
-}
clear : (Result a b -> msg) -> ElementId -> Cmd msg
clear tagger elementId =
    Task.attempt tagger <|
        Native.Element.clear elementId
