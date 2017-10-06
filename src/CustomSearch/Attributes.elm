module CustomSearch.Attributes exposing (..)


type MatchType
    = Any
    | Ordered
    | Prefix


type RefStyle
    = Tab
    | Link


type ImageLayout
    = Classic
    | Column
    | Popup


type Size
    = Large
    | Small
    | FilteredCSE
    | SizeInt Int


type Safe
    = Moderate
    | Off
    | Active



-- Attributes


type alias Attributes =
    List Attribute


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
