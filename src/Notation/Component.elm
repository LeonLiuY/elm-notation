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
    , stemDirection : Direction
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
                        , stemForDirection n.stemDirection
                        ]

                2 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemForDirection n.stemDirection
                        ]

                3 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemForDirection n.stemDirection
                        , flagForStem n.stemDirection flag8th
                        ]

                _ ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemForDirection n.stemDirection
                        , flagForStem n.stemDirection flag16th
                        ]
        )
        n
        attr



{- Private -}


stemForDirection : Direction -> Svg msg
stemForDirection direction =
    case direction of
        Up ->
            stem (stemLengthStandard - (Tuple.second noteHeadMeta.stemUpSE))
                [ let
                    x =
                        (Tuple.first noteHeadMeta.stemUpSE) - stemThickness / 2

                    y =
                        -stemLengthStandard
                  in
                    translate ( x, y )
                ]

        Down ->
            stem (stemLengthStandard - (Tuple.second noteHeadMeta.stemDownNW))
                [ let
                    x =
                        (Tuple.first noteHeadMeta.stemDownNW) + stemThickness / 2

                    y =
                        -(Tuple.second noteHeadMeta.stemDownNW)
                  in
                    translate ( x, y )
                ]


flagForStem : Direction -> (Direction -> List (Attribute msg) -> Svg msg) -> Svg msg
flagForStem direction flag =
    flag direction
        [ let
            movement =
                case direction of
                    Up ->
                        ( (Tuple.first noteHeadMeta.stemUpSE), -stemLengthStandard )

                    Down ->
                        ( (Tuple.first noteHeadMeta.stemDownNW), stemLengthStandard )
          in
            translate movement
        ]
