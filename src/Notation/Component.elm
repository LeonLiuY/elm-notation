module Notation.Component exposing (note)

{-|
# Components
@docs note
-}

import Notation.Basic exposing (..)
import Svg.Lazy exposing (..)
import Svg exposing (..)
import Notation.Variables exposing (..)
import Notation.Helper exposing (..)


type alias Note =
    { duration : Int
    }


{-| Draw a note
-}
note : Note -> List (Attribute msg) -> Svg msg
note n attr =
    lazy2
        (\n attr ->
            case n.duration of
                0 ->
                    noteHead whole attr

                1 ->
                    g ([] ++ attr)
                        [ noteHead half []
                        , stemUpSE
                        ]

                2 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemUpSE
                        ]

                3 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemUpSE
                        , flagForStemUp flag8thUp
                        ]

                _ ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemUpSE
                        , flagForStemUp flag16thUp
                        ]
        )
        n
        attr



{- Private -}


stemUpSE : Svg msg
stemUpSE =
    stem (stemLengthStandard - (Tuple.second noteHeadBlack.stemUpSE))
        [ let
            x =
                (Tuple.first noteHeadBlack.stemUpSE) - stemThickness / 2

            y =
                -stemLengthStandard
          in
            translate ( x, y )
        ]


flagForStemUp : (List (Attribute msg) -> Svg msg) -> Svg msg
flagForStemUp flag =
    flag
        [ let
            x =
                (Tuple.first noteHeadBlack.stemUpSE) - stemThickness

            y =
                -stemLengthStandard
          in
            translate ( x, y )
        ]
