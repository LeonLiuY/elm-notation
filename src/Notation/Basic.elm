module Notation.Basic exposing (staffLine, staff5Line, barlineThick, barlineThin, clef, gClef, fClef, beamUpper, beamLower, noteHead, whole, half, black, stem, augmentationDot, flat, sharp, natural, doubleFlat, doubleSharp)

{-| Draw kinds of music notations.

This module only draw raw components near coordinate (0, 0). Transformation & positioning should be controlled outside.
Each component specifies the detailed formation of the component.
All length parameters are the measurements expressed in staff spaces.

# Components
@docs staffLine, staff5Line, barlineThick, barlineThin, clef, gClef, fClef, beamUpper, beamLower, noteHead, whole, half, black, stem, augmentationDot, flat, sharp, natural, doubleFlat, doubleSharp
-}

import Svg exposing (..)
import Svg.Lazy exposing (..)
import Svg.Attributes exposing (..)
import Notation.Variables as Var


{-| Draw a single staff line from (0, 0) to (length , 0). The thickness of the line are equally divided by the x-axis.
-}
staffLine : Float -> List (Attribute msg) -> Svg msg
staffLine length attr =
    lazy2 (\length attr -> line ([ x1 "0", y1 "0", x2 (toString (length * Var.keyMeasure)), y2 "0", stroke Var.color, strokeWidth (toString Var.staffLineThickness) ] ++ attr) []) length attr


{-| Draw a standard five-line stave, where the top line lies on the x-axis from (0, 0) to (length , 0).
-}
staff5Line : Float -> List (Attribute msg) -> Svg msg
staff5Line length attr =
    lazy2 (\length attr -> g attr <| List.map (\n -> staffLine length [ y1 (toString (n * Var.keyMeasure)), y2 (toString (n * Var.keyMeasure)) ]) [ 0, 1, 2, 3, 4 ]) length attr


{-| Draw a thick barline from (0, 0) to (0, length) on the y-axis.
-}
barlineThick : Float -> List (Attribute msg) -> Svg msg
barlineThick length attr =
    lazy2 (\length attr -> line ([ x1 "0", y1 "0", x2 "0", y2 (toString (length * Var.keyMeasure)), stroke Var.color, strokeWidth (toString Var.thickBarlineThickness) ] ++ attr) []) length attr


{-| Draw a thin barline from (0, 0) to (0, length) on the y-axis.
-}
barlineThin : Float -> List (Attribute msg) -> Svg msg
barlineThin length attr =
    lazy2 (\length attr -> line ([ x1 "0", y1 "0", x2 "0", y2 (toString (length * Var.keyMeasure)), stroke Var.color, strokeWidth (toString Var.thinBarlineThickness) ] ++ attr) []) length attr


{-| Draw a celf, which takes the x-axis as the placement line on a stave and left ended at y-axis
-}
clef : Clef -> List (Attribute msg) -> Svg msg
clef c attr =
    lazy2 (\c attr -> glyph (stringOfClef c) attr) c attr


{-| -}
gClef : Clef
gClef =
    GClef


{-| -}
fClef : Clef
fClef =
    FClef


{-| Draw a beam, with the left-top corner (0, 0), and right-top corner (x, y).
    left-bottom and right-bottom corners will be adjusted to satisfy beamThickness.
-}
beamUpper : ( Float, Float ) -> List (Attribute msg) -> Svg msg
beamUpper ( x, y ) attr =
    let
        pts =
            String.join " "
                [ "0,0"
                , pointAsString ( x * Var.keyMeasure, y * Var.keyMeasure )
                , pointAsString ( x * Var.keyMeasure, y * Var.keyMeasure - beamOffset ( x, y ) )
                , pointAsString ( 0, 0 - beamOffset ( x, y ) )
                ]
    in
        lazy2 (\( x, y ) attr -> polygon ([ fill Var.color, stroke Var.color, points pts ] ++ attr) []) ( x, y ) attr


{-| Draw a beam, with the left-bottom corner (0, 0), and right-bottom corner (x, y).
    left-top and right-top corners will be adjusted to satisfy beamThickness.
-}
beamLower : ( Float, Float ) -> List (Attribute msg) -> Svg msg
beamLower ( x, y ) attr =
    let
        pts =
            String.join " "
                [ "0,0"
                , pointAsString ( x * Var.keyMeasure, y * Var.keyMeasure )
                , pointAsString ( x * Var.keyMeasure, y * Var.keyMeasure + beamOffset ( x, y ) )
                , pointAsString ( 0, beamOffset ( x, y ) )
                ]
    in
        lazy2 (\( x, y ) attr -> polygon ([ fill Var.color, stroke Var.color, points pts ] ++ attr) []) ( x, y ) attr


{-| Draw a note head, vertically centered by x-axis and left ended at y-axis
-}
noteHead : NoteHead -> List (Attribute msg) -> Svg msg
noteHead value attr =
    lazy2 (\value attr -> glyph (stringOfNoteValue value) attr) value attr


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


{-| Draw a stem line from (0, 0) to (0, length). The thickness of the line are equally divided by the y-axis.
-}
stem : Float -> List (Attribute msg) -> Svg msg
stem length attr =
    lazy2 (\length attr -> line ([ x1 "0", y1 "0", x2 "0", y2 (toString (length * Var.keyMeasure)), stroke Var.color, strokeWidth (toString Var.stemThickness) ] ++ attr) []) length attr


{-| Draw a augmentation dot centered at (0, 0).
-}
augmentationDot : List (Attribute msg) -> Svg msg
augmentationDot attr =
    lazy (\attr -> glyph "\xE1E7" attr) attr


{-| Draw a flat accidental around (0, 0), as it is matching a noteHead on the x-axis.
-}
flat : List (Attribute msg) -> Svg msg
flat attr =
    lazy (\attr -> glyph "\xE260" attr) attr


{-| Draw a sharp accidental around (0, 0), as it is matching a noteHead on the x-axis.
-}
sharp : List (Attribute msg) -> Svg msg
sharp attr =
    lazy (\attr -> glyph "\xE262" attr) attr


{-| Draw a natural accidental around (0, 0), as it is matching a noteHead on the x-axis.
-}
natural : List (Attribute msg) -> Svg msg
natural attr =
    lazy (\attr -> glyph "\xE261" attr) attr


{-| Draw a double sharp accidental around (0, 0), as it is matching a noteHead on the x-axis.
-}
doubleSharp : List (Attribute msg) -> Svg msg
doubleSharp attr =
    lazy (\attr -> glyph "\xE263" attr) attr


{-| Draw a double flat accidental around (0, 0), as it is matching a noteHead on the x-axis.
-}
doubleFlat : List (Attribute msg) -> Svg msg
doubleFlat attr =
    lazy (\attr -> glyph "\xE264" attr) attr



-- private


{-| -}
type Clef
    = GClef
    | FClef


{-| -}
type NoteHead
    = Whole
    | Half
    | Black


beamOffset : ( Float, Float ) -> Float
beamOffset ( x, y ) =
    sqrt (x ^ 2 + y ^ 2) / x * Var.beamThickness


pointAsString : ( Float, Float ) -> String
pointAsString ( x, y ) =
    String.join "," [ toString x, toString y ]


stringOfClef : Clef -> String
stringOfClef c =
    case c of
        GClef ->
            "\xE050"

        FClef ->
            "\xE062"


stringOfNoteValue : NoteHead -> String
stringOfNoteValue value =
    case value of
        Whole ->
            "\xE0A2"

        Half ->
            "\xE0A3"

        Black ->
            "\xE0A4"


{-| Draw glyph
-}
glyph : String -> List (Attribute msg) -> Svg msg
glyph str attr =
    lazy2 (\str attr -> text_ ([ fontFamily "Bravura", fontSize (toString Var.fontSize), color Var.color ] ++ attr) [ text str ]) str attr