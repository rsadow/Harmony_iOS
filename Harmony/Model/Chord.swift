//
// Created by Robert on 22.04.2016.
// Copyright (c) 2016 rsadow. All rights reserved.
//

import Foundation

extension String {
    subscript(i: Int) -> Character {
        get {
            return self[self.startIndex.advancedBy(i)]
        }
    }
}


protocol IFretboard {

}

protocol IScale {
    func generate(_ key: String, _ type: EScale) -> [String]
}

protocol IChordGenerator {
    func generate(key chordKey: String, type: EChord) -> Chord
}

enum EScale: String {
    case Major
}

enum EChord: String {
    case Major, Minor, Diminished, Diminished_Fifth, Augmented, Suspended_4th, Suspended_2nd,
         Dominant_7th, Major_7th, Minor_7th, Major_Minor_7th, Suspended_7th, Augmented_7th, Augmented_Major_7th,
         _7th_Augmented_Ninth, Half_Diminshed_7th, Diminished_7th, _7th_Diminished_Fifth, _7th_Flat_Nine
}

struct ChordCfg {
    let abrev:     String
    let intervals: String
}

struct ChordData {
    let key: String
    let type: EChord
    let notes: [String]
    let forms: [String]
    let cfg: ChordCfg
}

class Scale: IScale {

    init(){

    }

    func generate(_ key: String, _ type: EScale) -> [String] {
        return ["A"]
    }
}

class Fretborad: IFretboard {

    func note(string: Int, fret: Int) -> String {

    }
}

struct Chord {
    let key:   String
    let type:  EChord
    let notes: [String]
    let forms: [String]
    let cfg:   ChordCfg
}

class ChordGenerator: IChordGenerator {

    static let cfg: [EChord:ChordCfg] = [
            EChord.Major: ChordCfg(abrev: "maj", intervals: "1.3.5"),
            EChord.Minor: ChordCfg(abrev: "min", intervals: "1.b3.5"),

            EChord.Augmented_7th: ChordCfg(abrev: "aug7", intervals: "1.3.#5.b7"),
            EChord._7th_Augmented_Ninth: ChordCfg(abrev:"7+9", intervals: "1.3.5.b7.#9")
    ]

    let scale: IScale

    init(scale: IScale){
        self.scale = scale
    }

    func generate(key chordKey: String, type: EChord) -> Chord {

        let scaleNotes = scale.generate(chordKey, EScale.Major)
        let cfg = ChordGenerator.cfg[type]!
        let chordNotes:[String] = cfg.intervals.characters.split(".").map {
            (interval) -> String in
            var raiseOrLow = ""
            var ret = String(interval)
            if ret[0] == "b" || ret[0] == "#" {
                raiseOrLow = String(ret[0])
                ret  = String(ret[1])
            }

            let noteIndex: Int? = (Int(ret)! - 1)  % scaleNotes.count
            return scaleNotes[noteIndex!] + raiseOrLow
        }

        return Chord(key: chordKey,
                     type: type,
                     notes: chordNotes,
                     forms: scaleNotes,
                     cfg: cfg)
    }

}
