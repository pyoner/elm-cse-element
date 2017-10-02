module CustomSearch.Types.Refinements exposing (..)

--Refinements


type RefinementStyle
    = Tab
    | Link


type Refinements
    = Default String
    | Style RefinementStyle
