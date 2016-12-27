module DrawPreview exposing (..)

import Notation.Basic exposing (..)
import Notation.Component exposing (..)
import Notation.Helper exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Notation.Variables as Var


main : Html msg
main =
    div [ Html.Attributes.style [ ( "display", "flex" ), ( "flex-wrap", "wrap" ) ] ]
        [ coordinate "staffLine 4" <| staffLine 4 []
        , coordinate "staff5Line 4" <| staff5Line 4 []
        , coordinate "barlineThick" <| barlineThick 4 []
        , coordinate "barlineThin" <| barlineThin 4 []
        , coordinate "clef gClef" <| clef gClef []
        , coordinate "clef fClef" <| clef fClef []
        , coordinate "beamLower ( 4, 2 )" <| beamLower ( 4, 2 ) []
        , coordinate "beamUpper ( 4, -4 )" <| beamUpper ( 4, -4 ) []
        , coordinate "noteHead whole" <| noteHead whole []
        , coordinate "noteHead half" <| noteHead half []
        , coordinate "noteHead black" <| noteHead black []
        , coordinate "stem 4" <| stem 4 []
        , coordinate "augmentationDot" <| augmentationDot []
        , coordinate "flat" <| flat []
        , coordinate "sharp" <| sharp []
        , coordinate "natural" <| natural []
        , coordinate "doubleFlat" <| doubleFlat []
        , coordinate "doubleSharp" <| doubleSharp []
        , coordinate "flag8thUp" <| flag8thUp []
        , coordinate "flag8thDown" <| flag8thDown []
        , coordinate "flag16thUp" <| flag16thUp []
        , coordinate "flag16thDown" <| flag16thDown []
        , coordinate "note {duration = 0}" <| note { duration = 0 } []
        , coordinate "note {duration = 1}" <| note { duration = 1 } []
        , coordinate "note {duration = 2}" <| note { duration = 2 } []
        , coordinate "note {duration = 3}" <| note { duration = 3 } []
        ]


coordinate : String -> Svg msg -> Html msg
coordinate label content =
    let
        boxSize =
            toString 20

        lineLength =
            (toString 10)

        lineLengthDouble =
            (toString 20)
    in
        div [ Html.Attributes.style [ ( "padding", "20px" ), ( "height", "200px" ), ( "width", "200px" ) ] ]
            [ svg [ viewBox ("0 0 " ++ boxSize ++ " " ++ boxSize) ]
                [ line [ stroke "grey", strokeWidth "0.05", strokeDasharray "1, 1", x1 lineLength, y1 "0", x2 lineLength, y2 lineLength ] []
                , line [ stroke "grey", strokeWidth "0.05", x1 lineLength, y1 lineLength, x2 lineLength, y2 lineLengthDouble ] []
                , line [ stroke "grey", strokeWidth "0.05", strokeDasharray "1, 1", x1 "0", y1 lineLength, x2 lineLength, y2 lineLength ] []
                , line [ stroke "grey", strokeWidth "0.05", x1 lineLength, y1 lineLength, x2 lineLengthDouble, y2 lineLength ] []
                , g [ translate ( 10, 10 ) ] [ content ]
                ]
            , div [ Html.Attributes.style [ ( "text-align", "center" ) ] ] [ Html.text label ]
            ]
