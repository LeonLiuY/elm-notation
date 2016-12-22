module DrawPreview exposing (..)

import Notation.Basic exposing (..)
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
        ]


coordinate : String -> Svg msg -> Html msg
coordinate label content =
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
        div [ Html.Attributes.style [ ( "padding", "20px" ), ( "height", "200px" ), ( "width", "200px" ) ] ]
            [ svg [ viewBox ("0 0 " ++ boxSize ++ " " ++ boxSize) ]
                [ line [ stroke "grey", strokeDasharray "5, 5", x1 lineLength, y1 "0", x2 lineLength, y2 lineLength ] []
                , line [ stroke "grey", x1 lineLength, y1 lineLength, x2 lineLength, y2 lineLengthDouble ] []
                , line [ stroke "grey", strokeDasharray "5, 5", x1 "0", y1 lineLength, x2 lineLength, y2 lineLength ] []
                , line [ stroke "grey", x1 lineLength, y1 lineLength, x2 lineLengthDouble, y2 lineLength ] []
                , g [ transform trans ] [ content ]
                ]
            , div [ Html.Attributes.style [ ( "text-align", "center" ) ] ] [ Html.text label ]
            ]
