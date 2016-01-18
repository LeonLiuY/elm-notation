
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Draw exposing (..)
import Notation.Variables exposing (keyMeasure)
import Color exposing (darkGrey)
import Text


keyM : Int -> Int
keyM i =
    round (keyMeasure) * i


axis : String -> Form -> Element
axis name form =
    container (keyM 15) (keyM 15) middle
        <| collage
            (keyM 15)
            (keyM 15)
        <| List.concat
            [ [ traced (dashed Color.black) <| segment ( keyMeasure * -5, 0 ) ( keyMeasure * 5, 0 )
              , traced (dashed Color.black) <| segment ( 0, keyMeasure * -5 ) ( 0, keyMeasure * 5 )
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
            , [form, Text.fromString name |> leftAligned |> toForm |> moveY (keyMeasure * -6)]
            ]

partition : Int -> List a -> List (List a)

partition n list =
    if List.length list <= n then [list]
    else (List.take n list):: (partition n (List.drop n list))


renderFlowGrid : Int -> List Element -> Element

renderFlowGrid n elements =
    List.map (\elements -> flow right elements) (partition n elements) |> flow down

main : Element
main =
    renderFlowGrid 6
        [ axis "staffLine 4" <| staffLine 4
        , axis "fiveLineStaff 4" <| fiveLineStaff 4
        , axis "noteHead whole" <| noteHead whole
        , axis "noteHead half" <| noteHead half
        , axis "noteHead black" <| noteHead black
        , axis "clef gClef" <| clef gClef
        , axis "clef fClef" <| clef fClef
        ]
