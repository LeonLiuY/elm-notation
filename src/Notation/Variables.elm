module Notation.Variables exposing (..)


beamThickness : Float
beamThickness =
    0.5


fontSize : Float
fontSize =
    4


staffLineThickness : Float
staffLineThickness =
    0.13


thickBarlineThickness : Float
thickBarlineThickness =
    0.5


thinBarlineThickness : Float
thinBarlineThickness =
    0.16


stemThickness : Float
stemThickness =
    0.12


color : String
color =
    "black"


{-| relative to keyMeasure
-}
stemLengthStandard : Float
stemLengthStandard =
    3.5


noteHeadMeta =
    { stemUpSE = ( 1.18, 0.168 )
    , stemDownNW = ( 0.0, -0.168 )
    }
