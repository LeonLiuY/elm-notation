module Notation.Draw (staffLine, staff5Line, noteHead, stem, clef, Clef, gClef, fClef, NoteHead, whole, half, black) where

{-| Draw kinds of music notations.

This module only draw raw components near coordinate (0, 0). Transformation & positioning should be controlled outside.
Each component specifies the detailed formation of the component.

All length parameters are the measurements expressed in staff spaces.

# Components
@docs staffLine, staff5Line, stem, Clef, gClef, fClef,clef,  NoteHead, whole, half, black ,noteHead
-}

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Notation.Variables as Var exposing (keyMeasure)
import Text


{-| -}
type Clef
    = GClef
    | FClef


{-| -}
gClef : Clef
gClef =
    GClef


{-| -}
fClef : Clef
fClef =
    FClef


{-| -}
type NoteHead
    = Whole
    | Half
    | Black


{-| -}
whole : NoteHead
whole =
    Whole


{-| -}
half : NoteHead
half =
    Half


{-| -}
black : NoteHead
black =
    Black


{-| Draw a single staff line from (-length/2, 0) to (length/2 , 0). The thickness of the line are equally divided by the x-axis.

    staffLine 200
-}
staffLine : Float -> Form
staffLine length =
    segment ( 0 - length / 2 * keyMeasure, 0 ) ( 0 + length / 2 * keyMeasure, 0 ) |> traced { defaultLine | width = Var.staffLineThickness }


{-| Draw a stem line from (0, 0) to (0, length). The thickness of the line are equally divided by the y-axis.

    stem 200
-}
stem : Float -> Form
stem length =
    segment ( 0, 0 ) ( 0, 0 + length * keyMeasure ) |> traced { defaultLine | width = Var.stemThickness }


{-| Draw a standard five-line stave, where the middle line lies on the x-axis from (-length/2, 0) to (length/2 , 0).

    staff5Line 200
-}
staff5Line : Float -> Form
staff5Line length =
    group <| List.map (\n -> moveY (0 - n * Var.staffSpace) <| staffLine length) [-2..2]


{-| Draw a note head, centered at (0, 0)

    noteHead whole
-}
noteHead : NoteHead -> Form
noteHead value =
    glyph (stringOfNoteValue value)


{-| Draw a celf, which takes the x-axis as the placement line on a stave

    celf gCelf
-}
clef : Clef -> Form
clef c =
    glyph (stringOfClef c)



{- PRIVATES -}


{-| Draw glyph
-}
glyph : String -> Form
glyph str =
    Text.fromString str |> Text.height Var.fontSize |> Text.typeface [ "Bravura" ] |> leftAligned |> toForm


stringOfNoteValue : NoteHead -> String
stringOfNoteValue value =
    case value of
        Whole ->
            "\xE0A2"

        Half ->
            "\xE0A3"

        Black ->
            "\xE0A4"


stringOfClef : Clef -> String
stringOfClef c =
    case c of
        GClef ->
            "\xE050"

        FClef ->
            "\xE062"
