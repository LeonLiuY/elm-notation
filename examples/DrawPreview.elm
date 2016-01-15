
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Draw exposing (..)
import Notation.Variables exposing (keyMeasure)
import Color exposing (darkGrey)



keyM i =
    round (keyMeasure) * i


axis : Form -> Element
axis form =
    container (keyM 15) (keyM 15) middle
        <| collage
            (keyM 10)
            (keyM 10)
        <| List.concat
            [ [ traced (dashed Color.black) <| segment ( keyMeasure * -10, 0 ) ( keyMeasure * 10, 0 )
              , traced (dashed Color.black) <| segment ( 0, keyMeasure * -10 ) ( 0, keyMeasure * 10 )
              ]
            , List.concatMap
                (\n ->
                    [ traced (dotted darkGrey) <| segment ( keyMeasure * -10, keyMeasure * n ) ( keyMeasure * 10, keyMeasure * n )
                    , traced (dotted darkGrey) <| segment ( keyMeasure * -10, keyMeasure * -n ) ( keyMeasure * 10, keyMeasure * -n )
                    , traced (dotted darkGrey) <| segment ( keyMeasure * n, keyMeasure * -10 ) ( keyMeasure * n, keyMeasure * 10 )
                    , traced (dotted darkGrey) <| segment ( keyMeasure * -n, keyMeasure * -10 ) ( keyMeasure * -n, keyMeasure * 10 )
                    ]
                )
                [1..10]
            , [form]
            ]


main : Element
main =
    flow
        down
        [ axis <| staffLine 4
        , axis <| fiveLineStaff 4
        , axis <| noteHead whole
        , axis <| noteHead half
        , axis <| noteHead black
        , axis <| clef gClef
        , axis <| clef fClef
        ]
