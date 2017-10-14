module CustomSearch.Attributes exposing (..)

{-| Attributes
# Types
@docs MatchType, RefStyle, ImageLayout, Size, Safe

# Attributes
@docs Attribute, Attributes
-}


{-| MatchType
-}
type MatchType
    = Any
    | Ordered
    | Prefix


{-| RefStyle
-}
type RefStyle
    = Tab
    | Link


{-| ImageLayout
-}
type ImageLayout
    = Classic
    | Column
    | Popup


{-| Size
-}
type Size
    = Large
    | Small
    | FilteredCSE
    | SizeInt Int


{-| Safe
-}
type Safe
    = Moderate
    | Off
    | Active



-- Attributes


{-| Attributes
-}
type alias Attributes =
    List Attribute


{-| Attribute
-}
type Attribute
    = Gname String
    | AutoSearchOnLoad Bool
    | EnableHistory Bool
    | NewWindow Bool
    | QueryParameterName String
    | ResultsUrl String
      -- AutoComplete
    | AutoCompleteMatchType MatchType
    | AutoCompleteMaxCompletions Int
    | AutoCompleteMaxPromotions Int
    | AutoCompleteValidLanguages String
      -- Refinements
    | DefaultToRefinement String
    | RefinementStyle RefStyle
      -- ImageSearch
    | EnableImageSearch Bool
    | DefaultToImageSearch Bool
    | ImageSearchResultSetSize Size
    | ImageSearchLayout ImageLayout
    | ImageCR String
    | ImageGL String
    | ImageAsSiteSearch String
    | ImageAsOQ String
    | ImageSortBy String
    | ImageFilter String
      -- WebSearch
    | DisableWebSearch Bool
    | WebSearchResultSetSize Size
    | WebSearchSafesearch Safe
    | WebSearchQueryAddition String
    | WebCR String
    | WebGL String
    | WebAsSiteSearch String
    | WebAsOQ String
    | WebSortBy String
    | WebFilter String
      -- SearchResults
    | EnableOrderBy Bool
    | LinkTarget String
    | NoResultsString String
    | ResultSetSize Size
    | SafeSearch Safe
      -- Ads
    | AdClient String
    | AdEnableTest Bool
    | AdChannel String
      -- Google Analytics
    | GaCategoryParameter String
    | GaQueryParameter String
