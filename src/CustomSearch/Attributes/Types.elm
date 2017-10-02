module CustomSearch.Attributes.Types exposing (..)

import CustomSearch.Types.General exposing (General)
import CustomSearch.Types.Autocomplete exposing (Autocomplete)
import CustomSearch.Types.Refinements exposing (Refinements)
import CustomSearch.Types.ImageSearch exposing (ImageSearch)
import CustomSearch.Types.WebSearch exposing (WebSearch)
import CustomSearch.Types.SearchResults exposing (SearchResults)
import CustomSearch.Types.Analytics exposing (Analytics)
import CustomSearch.Types.Ads exposing (Ads)


type Attribute
    = AttrGeneral General
    | AttrAutocomplete Autocomplete
    | AttrRefinements Refinements
    | AttrImageSearch ImageSearch
    | AttrWebSearch WebSearch
    | AttrSearchResults SearchResults
    | AttrAnalytics Analytics
    | AttrAds Ads


type alias Attributes =
    List Attribute



--Component attributes


type Search
    = Web WebSearch
    | Image ImageSearch
    | Both WebSearch ImageSearch
