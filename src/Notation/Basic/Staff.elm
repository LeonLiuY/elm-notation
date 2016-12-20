module Notation.Basic.Staff exposing (staffLine, staff5Line)

{-|
@docs staffLine, staff5Line
-}

import Svg exposing (..)
import Svg.Lazy exposing (..)
import Svg.Attributes exposing (..)
import Notation.Variables as Var


{-| Draw a single staff line from (-length/2, 0) to (length/2 , 0). The thickness of the line are equally divided by the x-axis.

    staffLine 200
-}
staffLine : Float -> List (Attribute msg) -> Svg msg
staffLine length attr =
    lazy2 (\length attr -> line ([ x1 "0", y1 "0", x2 (toString (length * Var.keyMeasure)), y2 "0", stroke Var.color, strokeWidth (toString staffLineThickness) ] ++ attr) []) length attr


{-| Draw a standard five-line stave, where the middle line lies on the x-axis from (-length/2, 0) to (length/2 , 0).

    staff5Line 200
-}
staff5Line : Float -> List (Attribute msg) -> Svg msg
staff5Line length attr =
    lazy2 (\length attr -> g attr <| List.map (\n -> staffLine length [ y1 (toString (n * Var.keyMeasure)), y2 (toString (n * Var.keyMeasure)) ]) [ 0, 1, 2, 3, 4 ]) length attr



-- private


staffLineThickness : Float
staffLineThickness =
    0.13 * Var.keyMeasure
