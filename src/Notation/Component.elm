module Notation.Component exposing (note)

import Notation.Basic exposing (..)
import Svg.Lazy exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Notation.Variables exposing (..)


type alias Note =
    { duration : Int
    }


translate ( x, y ) =
    transform ("translate(" ++ (toString x) ++ "," ++ (toString y) ++ ")")


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
