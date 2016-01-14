module Notation.Draw where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Variables as Var
import Text
import Notation.Model exposing (..)

staffLine : Float -> Float -> Float -> Form
staffLine length x y = segment (x, y) (x + length, y) |> traced {defaultLine | width= Var.staffLineThickness}

fiveLineStaff : Float -> Float -> Float -> Form
fiveLineStaff length x y = group <| List.map(\n -> staffLine length x (y - n * Var.staffSpace)) [0 .. 4]


stringOfNoteValue : NoteValue -> String
stringOfNoteValue value =
    case value of
        V1 -> "\xe1d2"
        V2 -> "\xe1d3"
        V4 -> "\xe1d5"
        V8 -> "\xe1d7"
        V16 -> "\xe1d9"
        V32 -> "\xe1db"
        V64 -> "\xe1dd"
        V128 -> "\xe1df"
        V256 -> "\xe1e1"

glyph : String -> Text.Text
glyph str = Text.fromString str |> Text.height Var.fontSize |> Text.typeface ["Bravura"]


note : Notation.Model.Note -> Float -> Float -> Form

note n x y = glyph (stringOfNoteValue n.value) |> leftAligned  |> toForm |> move (x, y + (toFloat(n.pitch) - 10) * Var.keyMeasure / 2 )
