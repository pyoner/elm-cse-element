module CustomSearch.Attributes.Ads exposing (..)

import CustomSearch.Types.Ads as Ads
import CustomSearch.Attributes.Types exposing (Attribute(AttrAds))


client : String -> Attribute
client v =
    AttrAds (Ads.Client v)


enableTest : Bool -> Attribute
enableTest flag =
    AttrAds (Ads.EnableTest flag)


channel : String -> Attribute
channel v =
    AttrAds (Ads.Channel v)
