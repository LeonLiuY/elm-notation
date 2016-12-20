module DrawPreview exposing (..)

import Notation.Basic.Staff exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Notation.Variables as Var


main : Html msg
main =
    coordinate <| staff5Line 4 []


coordinate : Svg msg -> Html msg
coordinate content =
    let
        boxSize =
            toString (Var.keyMeasure * 20)

        lineLength =
            (toString (Var.keyMeasure * 10))

        lineLengthDouble =
            (toString (Var.keyMeasure * 20))

        trans =
            "translate(" ++ lineLength ++ "," ++ lineLength ++ ")"
    in
        div [ Html.Attributes.style [ ( "padding", "10px" ), ( "height", "200px" ), ( "width", "200px" ) ] ]
            [ svg [ viewBox ("0 0 " ++ boxSize ++ " " ++ boxSize) ]
                [ line [ stroke "grey", strokeDasharray "5, 5", x1 lineLength, y1 "0", x2 lineLength, y2 lineLength ] []
                , line [ stroke "grey", x1 lineLength, y1 lineLength, x2 lineLength, y2 lineLengthDouble ] []
                , line [ stroke "grey", strokeDasharray "5, 5", x1 "0", y1 lineLength, x2 lineLength, y2 lineLength ] []
                , line [ stroke "grey", x1 lineLength, y1 lineLength, x2 lineLengthDouble, y2 lineLength ] []
                , g [ transform trans ] [ content ]
                ]
            ]
