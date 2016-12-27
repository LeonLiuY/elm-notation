module Notation.Helper exposing (..)

import Svg.Attributes exposing (transform)
import Svg


translate : ( Float, Float ) -> Svg.Attribute msg
translate ( x, y ) =
    transform ("translate(" ++ (toString x) ++ "," ++ (toString y) ++ ")")
