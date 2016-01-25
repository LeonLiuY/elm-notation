module Main (..) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Draw exposing (..)
import Notation.Variables exposing (keyMeasure)
import Color exposing (darkGrey)
import Text
import Window


keyM : Int -> Int
keyM i =
    round (keyMeasure) * i


axis : String -> Form -> Element
axis name form =
    collage
        (keyM 15)
        (keyM 15)
        <| List.concat
            [ [ traced (dashed <| Color.greyscale 0.5) <| segment ( keyMeasure * -5, 0 ) ( keyMeasure * 5, 0 )
              , traced (dashed <| Color.greyscale 0.5) <| segment ( 0, keyMeasure * -5 ) ( 0, keyMeasure * 5 )
              ]
            , List.concatMap
                (\n ->
                    [ traced (dotted darkGrey) <| segment ( keyMeasure * -5, keyMeasure * n ) ( keyMeasure * 5, keyMeasure * n )
                    , traced (dotted darkGrey) <| segment ( keyMeasure * -5, keyMeasure * -n ) ( keyMeasure * 5, keyMeasure * -n )
                    , traced (dotted darkGrey) <| segment ( keyMeasure * n, keyMeasure * -5 ) ( keyMeasure * n, keyMeasure * 5 )
                    , traced (dotted darkGrey) <| segment ( keyMeasure * -n, keyMeasure * -5 ) ( keyMeasure * -n, keyMeasure * 5 )
                    ]
                )
                [1..5]
            , [ form, Text.fromString name |> leftAligned |> toForm |> moveY (keyMeasure * -6) ]
            ]


partition : Int -> List a -> List (List a)
partition n list =
    if List.length list <= n then
        [ list ]
    else
        (List.take (max n 1) list) :: (partition (max n 1) (List.drop (max n 1) list))


renderFlowGrid : Int -> List Element -> Element
renderFlowGrid n elements =
    List.map (\elements -> flow right elements) (partition n elements) |> flow down


main : Signal Element
main =
    Signal.map
        (\width ->
            flow
                down
                [ (Text.fromString "1 cell = 1 keyMeasure(staffSpace) x 1 keyMeasure" |> centered)
                , renderFlowGrid
                    (width // (keyM 15))
                    [ axis "staffLine 4" <| staffLine 4
                    , axis "fiveLineStaff 4" <| staff5Line 4
                    , axis "stem 4" <| stem 4
                    , axis "noteHead whole" <| noteHead whole
                    , axis "noteHead half" <| noteHead half
                    , axis "noteHead black" <| noteHead black
                    , axis "clef gClef" <| clef gClef
                    , axis "clef fClef" <| clef fClef
                    , axis "barlineThick 4" <| barlineThick 4
                    , axis "barlineThin 4" <| barlineThin 4
                    , axis "beamUpper (4, 2)" <| beamUpper ( 4, 2 )
                    , axis "beamLower (4, -4)" <| beamLower ( 4, -4 )
                    ]
                ]
        )
        Window.width
