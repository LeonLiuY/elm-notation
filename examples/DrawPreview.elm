module DrawPreview exposing (..)

import Notation.Basic exposing (..)
import Notation.Component exposing (..)
import Notation.Helper exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ h1 [] [ Html.text "Basic" ]
        , div [ Html.Attributes.style [ ( "display", "flex" ), ( "flex-wrap", "wrap" ) ] ]
            [ coordinate "staffLine 4" <| staffLine 4 []
            , coordinate "staff5Line 4" <| staff5Line 4 []
            , coordinate "barlineThick" <| barlineThick 4 []
            , coordinate "barlineThin" <| barlineThin 4 []
            , coordinate "clef gClef" <| clef GClef []
            , coordinate "clef fClef" <| clef FClef []
            , coordinate "beamLower ( 4, 2 )" <| beamLower ( 4, 2 ) []
            , coordinate "beamUpper ( 4, -4 )" <| beamUpper ( 4, -4 ) []
            , coordinate "noteHead Whole" <| noteHead Whole []
            , coordinate "noteHead Half" <| noteHead Half []
            , coordinate "noteHead Black" <| noteHead Black []
            , coordinate "stem 4" <| stem 4 []
            , coordinate "augmentationDot" <| augmentationDot []
            , coordinate "flat" <| flat []
            , coordinate "sharp" <| sharp []
            , coordinate "natural" <| natural []
            , coordinate "doubleFlat" <| doubleFlat []
            , coordinate "doubleSharp" <| doubleSharp []
            , coordinate "flag8th Up" <| flag8th Up []
            , coordinate "flag8th Down" <| flag8th Down []
            , coordinate "flag16th Up" <| flag16th Up []
            , coordinate "flag16th Down" <| flag16th Down []
            , coordinate "slur" <| slur ( 1, 2 ) ( 2.4, 3 ) ( 5, 2 ) []
            ]
        , h1 [] [ Html.text "Component: notes" ]
        , div [ Html.Attributes.style [ ( "display", "flex" ), ( "flex-wrap", "wrap" ) ] ]
            [ coordinate "note {duration = 0}" <| g [] [ note { duration = 0, stemDirection = Up } [], staff5Line 4 [ translate ( -1, -3.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 1}" <| g [] [ note { duration = 1, stemDirection = Up } [], staff5Line 4 [ translate ( -1, -3.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 2}" <| g [] [ note { duration = 2, stemDirection = Up } [], staff5Line 4 [ translate ( -1, -3.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 3}" <| g [] [ note { duration = 3, stemDirection = Up } [], staff5Line 4 [ translate ( -1, -3.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 4}" <| g [] [ note { duration = 4, stemDirection = Up } [], staff5Line 4 [ translate ( -1, -3.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 1}" <| g [] [ note { duration = 1, stemDirection = Down } [], staff5Line 4 [ translate ( -1, -0.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 2}" <| g [] [ note { duration = 2, stemDirection = Down } [], staff5Line 4 [ translate ( -1, -0.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 3}" <| g [] [ note { duration = 3, stemDirection = Down } [], staff5Line 4 [ translate ( -1, -0.5 ), opacity "0.1" ] ]
            , coordinate "note {duration = 4}" <| g [] [ note { duration = 4, stemDirection = Down } [], staff5Line 4 [ translate ( -1, -0.5 ), opacity "0.1" ] ]
            ]
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
