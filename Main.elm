module Main (..) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Model exposing (..)
import Notation.Draw exposing (..)
import Notation.Variables as Var


type alias Model =
    List Note


type alias View =
    List Note -> Element


model : Model
model = List.map(\n -> { pitch = n, value = if n % 2 == 0 then V4 else V8 }) [2..10]


view : View
view notes =
    collage
        1000
        1000 <|
        fiveLineStaff 800 -400 400 :: (glyph "\xe050" |> move (-350, 400 - 3 * Var.staffSpace)) ::
        List.indexedMap (\i n -> note n (toFloat(i + 1) * 40 - 300)  400) model


main : Element
main =
    view model
