//
//  ChordTests.swift
//  HarmonyTests
//
//  Created by Robert on 22.04.2016.
//  Copyright (c) 2016 rsadow. All rights reserved.
//

import XCTest
import Nimble
@testable import Harmony

class ScaleMock: IScale {
    func generate(_ key: String, _ type: EScale) -> [String] {
        return ["C", "D", "E", "F", "G", "A", "B"]
    }
}

class ChordTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChordNotes() {
        let cg = ChordGenerator(scale: ScaleMock())

        expect(cg.generate(key: "C", type: EChord.Major).notes) == ["C","E","G"]

        expect(cg.generate(key: "C", type: EChord.Minor).notes) == ["C","Eb","G"]
        expect(cg.generate(key: "C", type: EChord._7th_Augmented_Ninth).notes) == ["C","E","G","Bb","D#"]
    }

    func testChordForms() {
        let cg = ChordGenerator(scale: ScaleMock())

        expect(cg.generate(key: "C", type: EChord.Major).forms) == [["0.1.2.0.3.x"]]
    }
}
