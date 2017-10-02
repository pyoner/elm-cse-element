module CustomSearch.Attributes.SearchResults exposing (..)

import CustomSearch.Types.Common
    exposing
        ( SafeSearch(..)
        , SearchParameter(..)
        , Size
        )
import CustomSearch.Types.SearchResults as SearchResults
import CustomSearch.Attributes.Types exposing (Attribute(AttrSearchResults))


enableOrderBy : Bool -> Attribute
enableOrderBy flag =
    AttrSearchResults (SearchResults.EnableOrderBy flag)



--SafeSearch helpers


safeSearch : SafeSearch -> Attribute
safeSearch v =
    AttrSearchResults (SearchResults.SafeSearch v)


safeSearchModerate : Attribute
safeSearchModerate =
    safeSearch Moderate


safeSearchOff : Attribute
safeSearchOff =
    safeSearch Off


safeSearchActive : Attribute
safeSearchActive =
    safeSearch Active



--end


setSize : Size -> Attribute
setSize v =
    AttrSearchResults (SearchResults.SetSize v)


linkTarget : String -> Attribute
linkTarget v =
    AttrSearchResults (SearchResults.LinkTarget v)


noResultsString : String -> Attribute
noResultsString v =
    AttrSearchResults (SearchResults.NoResultsString v)
