module Notation.Draw (staffLine, fiveLineStaff, noteHead, stem) where

{-| Draw kinds of music notations.

This module only draw raw components near coordinate (0, 0). Transformation & positioning should be controlled outside.
Each component specifies the detailed formation of the component.

All length parameters are the measurements expressed in staff spaces.

# Components
@docs staffLine, fiveLineStaff, noteHead, stem
-}

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Model exposing (..)
import Notation.Variables as Var exposing (keyMeasure)
import Text


{-| Draw a single staff line from (0, 0) to (length, 0). The width of the line are equally divided by the x-axis.

    staffLine 200
-}
staffLine : Float -> Form
staffLine length =
    segment ( 0, 0 ) ( 0 + length * keyMeasure, 0 ) |> traced { defaultLine | width = Var.staffLineThickness }


{-| Draw a stem line from (0, 0) to (0, length). The width of the line are equally divided by the y-axis.

    stem 200
-}
stem : Float -> Form
stem length =
    segment ( 0, 0 ) ( 0, 0 + length * keyMeasure ) |> traced { defaultLine | width = Var.stemThickness }


{-| Draw a standard five-line staff, where the top line is exactly same length & location with a single staff line (staffLine length)

    fiveLineStaff 200
-}
fiveLineStaff : Float -> Form
fiveLineStaff length =
    group <| List.map (\n -> moveY (0 - n * Var.staffSpace) <| staffLine length) [0..4]


{-| Draw a note head, centered at (0, 0)

    noteHead whole
-}
noteHead : NoteHead -> Form
noteHead value =
    glyph (stringOfNoteValue value)


stringOfNoteValue : NoteHead -> String
stringOfNoteValue value =
    case value of
        Whole ->
            "\xE0A2"

        Half ->
            "\xE0A3"

        Black ->
            "\xE0A4"



{- PRIVATES -}


{-| Draw glyph
-}
glyph : String -> Form
glyph str =
    Text.fromString str |> Text.height Var.fontSize |> Text.typeface [ "Bravura" ] |> leftAligned |> toForm
