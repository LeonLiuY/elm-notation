module Notation.FontMeta exposing (..)

fontName = "Bravura"

engravingDefaults = {
  beamThickness = 0.5,
  staffLineThickness = 0.13,
  thickBarlineThickness = 0.5,
  thinBarlineThickness = 0.16,
  stemThickness = 0.12
 }

glyphsWithAnchors = {
 noteheadHalf = {
   stemDownNW = (
       0.0,
       -0.168
   ),
   stemUpSE = (
       1.18,
       0.168
   )
 },
 noteheadBlack = {
   stemDownNW = (
       0.0,
       -0.168
   ),
   stemUpSE = (
       1.18,
       0.168
   )
  }
 }
