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
                    noteHead half attr

                2 ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stem stemLengthStandard
                            [ let
                                x =
                                    (Tuple.first noteHeadBlack.stemUpSE) - stemThickness / 2

                                y =
                                    -(Tuple.second noteHeadBlack.stemUpSE + stemLengthStandard)
                              in
                                translate ( x, y )
                            ]
                        ]

                _ ->
                    g ([] ++ attr)
                        [ noteHead black []
                        , stem stemLengthStandard
                            [ let
                                x =
                                    (Tuple.first noteHeadBlack.stemUpSE) - stemThickness / 2

                                y =
                                    -(Tuple.second noteHeadBlack.stemUpSE + stemLengthStandard)
                              in
                                translate ( x, y )
                            ]
                        , flag8thUp
                            [ let
                                x =
                                    (Tuple.first noteHeadBlack.stemUpSE) - stemThickness

                                y =
                                    -(Tuple.second noteHeadBlack.stemUpSE + stemLengthStandard)
                              in
                                translate ( x, y )
                            ]
                        ]
        )
        n
        attr
