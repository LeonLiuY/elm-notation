module Notation.Model (..) where


type NoteValue
    = V1
    | V2
    | V4
    | V8
    | V16
    | V32
    | V64
    | V128
    | V256


type alias Note =
    { pitch : Int
    , value : NoteValue
    }
