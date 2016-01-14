module Main (..) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

import Notation.Model exposing (..)

import Text exposing (..)

keyMeasure : Float
keyMeasure = 10

type alias Model =
    List Note


type alias View =
    List Note -> Element


model : Model
model =
    [ { pitch = 0, value = 1 }, { pitch = 1, value = 1 }, { pitch = 2, value = 1 } ]


view : View
view notes =
    collage
        1000
        1000
        [ traced { defaultLine | width = 10 } <| segment ( -150, -20 ) ( 150, -20 )
        , traced { defaultLine | width = 10 } <| segment ( -150, -10 ) ( 150, -10 )
        , traced { defaultLine | width = 2 } <| segment ( -150, 0 ) ( 150, 0 )
        , traced { defaultLine | width = 2 } <| segment ( -150, 10 ) ( 150, 10 )
        , traced { defaultLine | width = 2 } <| segment ( -150, 20 ) ( 150, 20 )
        , toForm <| leftAligned <| typeface ["Bravura"] <| Text.height 40 <| fromString "\xe004"
        ]


main : Element
main =
    view model
