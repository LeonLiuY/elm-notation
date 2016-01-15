module Main (..) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Model exposing (..)
import Notation.Draw exposing (..)


type alias Model =
    List Note


type alias View =
    List Note -> Element


model : Model
model = List.map(\n -> { pitch = n, value = if n % 2 == 0 then V4 else V8 }) [2..10]

axis : Form -> Element

axis form =  container 300 300  middle <| collage 200 200 [
    traced defaultLine <| segment (-200, 0) (200, 0),
    traced defaultLine <| segment (0, -200) (0, 200),
    form
 ]

view : View
view notes =
    flow down [
        axis <| staffLine 100,
        axis <| fiveLineStaff 100,
        axis <| noteHead whole,
        axis <| noteHead half,
        axis <| noteHead black
        {-collage
            1000
            1000 <|
            move (-400, 400) (fiveLineStaff 800) :: (glyph "\xe050" |> move (-350, 400 - 3 * Var.staffSpace)) ::
            List.indexedMap (\i n -> note n (toFloat(i + 1) * 40 - 300)  400) model -}
    ]


main : Element
main =
    view model
