//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by YYang on 2/12/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
    var gameUnderTest: BullsEyeGame!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameUnderTest = nil
        
        
        super.tearDown()
    }

    func testScoreIsComputed()  {
        //1. given
        let guess = gameUnderTest.targetValue + 5
        //2. when
        _ = gameUnderTest.check(guess: guess)
        //3.then
        let roundScore = gameUnderTest.scoreRound
        XCTAssertEqual(roundScore, 95, "Score computed from guess is wrong")
        
    }

    
    func testScoreIsComputedWhenGuessLTTarget()  {
        let guess = gameUnderTest.targetValue - (-5 )
        _ = gameUnderTest.check(guess: guess)
        let roundScore = gameUnderTest.scoreRound
        XCTAssertEqual(roundScore, 95, "Score computed from guess is wrong")
    }
    

}
