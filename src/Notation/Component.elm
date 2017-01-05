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
import Notation.FontMeta exposing (..)


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
                        , stemForDirection n.stemDirection glyphsWithAnchors.noteheadHalf
                        ]

                2 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemForDirection n.stemDirection glyphsWithAnchors.noteheadBlack
                        ]

                3 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemForDirection n.stemDirection glyphsWithAnchors.noteheadBlack
                        , flagForStem n.stemDirection flag8th glyphsWithAnchors.noteheadBlack
                        ]

                _ ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stemForDirection n.stemDirection glyphsWithAnchors.noteheadBlack
                        , flagForStem n.stemDirection flag16th glyphsWithAnchors.noteheadBlack
                        ]
        )
        n
        attr


stemForDirection : Direction -> { a | stemUpSE : ( Float, Float ), stemDownNW : ( Float, Float ) } -> Svg msg
stemForDirection direction meta =
    case direction of
        Up ->
            stem (stemLengthStandard - (Tuple.second meta.stemUpSE))
                [ let
                    x =
                        (Tuple.first meta.stemUpSE) - engravingDefaults.stemThickness

                    y =
                        -stemLengthStandard
                  in
                    translate ( x, y )
                ]

        Down ->
            stem (stemLengthStandard + (Tuple.second meta.stemDownNW))
                [ let
                    x =
                        (Tuple.first meta.stemDownNW)

                    y =
                        -(Tuple.second meta.stemDownNW)
                  in
                    translate ( x, y )
                ]


flagForStem : Direction -> (Direction -> List (Attribute msg) -> Svg msg) -> { a | stemUpSE : ( Float, Float ), stemDownNW : ( Float, Float ) } -> Svg msg
flagForStem direction flag meta =
    flag direction
        [ let
            movement =
                case direction of
                    Up ->
                        ( (Tuple.first meta.stemUpSE), -stemLengthStandard )

                    Down ->
                        ( (Tuple.first meta.stemDownNW), stemLengthStandard )
          in
            translate movement
        ]
