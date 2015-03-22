//
//  pokerTests.swift
//  pokerTests
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 Yonatan Bergman. All rights reserved.
//

import UIKit
import XCTest

class pokerTests: XCTestCase {
    
    let kingHigh = "2H 3D 5S 9C KH"
    let pairOfTwos = "2H 2C 3D 5S 4D"
    
    func compareHands(hand1:String, _ hand2:String) -> Int{
        return Hand(string: hand1).compare(Hand(string: hand2))
    }
    
    //MARK: HighCard
    func testHighCard() {
        XCTAssert(compareHands("2H 3D 5S 9C AD", kingHigh) == 1, "High Card")
    }

    func testHighCardPlayer2() {
        XCTAssert(compareHands("2H 3D 5S 9C JD", kingHigh) == -1, "High Card Player 2")
    }
    
    func test2ndHighCard(){
        XCTAssert(compareHands("2H 3D 5S TC KD", "2H 3D 5S 9C KH") == 1, "2nd Highest Card")
    }
    
    func testHighCardTie() {
        XCTAssert(compareHands("2H 3D 5S 9C KD", kingHigh) == 0, "Tie")
    }
    
    //MARK: Pair
    func testPair() {
        XCTAssert(compareHands(pairOfTwos, kingHigh) == 1, "Simple Pair")
    }
    
    func testPairVsStrongerPair() {
        XCTAssert(compareHands(pairOfTwos, "3D 3S 2H 9C KH") == -1, "Stronger Pair")
    }
    
    func testPairWithKicker() {
        XCTAssert(compareHands(pairOfTwos, "2H 2C 3D 5S KH") == -1, "Pair With Kicker")
    }
    
    func testPairTie() {
        XCTAssert(compareHands(pairOfTwos, "2H 2C 3D 5S 4H") == 0, "Pair With Tie")
    }
    
    //MARK: Two Pair
    func testTwoPair() {
        XCTAssert(compareHands("2H 2D 3S 3C 4D", kingHigh) == 1, "Two Pair")
    }
    
    func testTwoPairAgainstPair() {
        XCTAssert(compareHands("2H 2D 3S 3C 4D", "6S 6D 8H JC KH") == 1, "Two Pair Against Pair")
    }

    func testTwoPairStrongerTopPair() {
        XCTAssert(compareHands("2H 2D 5S 5C 4D", "2H 2D 6S 6C 4D") == -1, "Two Pair Stronger Top Pair")
    }

    func testTwoPairStrongerBottomPair() {
        XCTAssert(compareHands("2H 2D 5S 5C 4D", "3H 3D 5S 5C 4D") == -1, "Two Pair Stronger Bottom Pair")
    }

    func testTwoPairWithKicker() {
        XCTAssert(compareHands("2H 2D 5S 5C 4D", "2H 2D 5S 5C 8D") == -1, "Two Pair With Kicker")
    }

    func testTwoPairTie() {
        XCTAssert(compareHands("2H 2D 5S 5C 4D", "2H 2D 5S 5C 4D") == 0, "Two Pair Tie")
    }
    
    //MARK: Three of a kind
    func testThreeOfAKind() {
        XCTAssert(compareHands("2H 2D 2S 3C 4D", kingHigh) == 1, "Three Of A Kind")
    }
    
    func testThreeOfAKindAgainstPair() {
        XCTAssert(compareHands("2H 2D 2S 3C 4D", "6S 6D 8H JC KH") == 1, "Three Of A Kind Against Pair")
    }
    
    func testThreeOfAKindTwoPair() {
        XCTAssert(compareHands("2H 2D 2S 5C 4D", "2H 2D 6S 6C 4D") == 1, "Three Of A Kind Against Two Pair")
    }
    
    func testThreeOfAKindStrongerThreeOfAKind() {
        XCTAssert(compareHands("2H 2D 2S 5C 4D", "3H 3D 3S 5C 4D") == -1, "Three Of A Kind Stronger Three Of A Kind")
    }
    
    func testThreeOfAKindWithKicker() {
        XCTAssert(compareHands("2H 2D 2S 5C 4D", "2H 2D 2S 5C 8D") == -1, "Three Of A Kind With Kicker")
    }
    
    func testThreeOfAKindTie() {
        XCTAssert(compareHands("2H 2D 2S 5C 4D", "2H 2D 2S 5C 4D") == 0, "Three Of A Kind Tie")
    }
    
    //MARK: Straight
    func testStraight() {
        XCTAssert(compareHands("2H 3D 4S 5C 6D", kingHigh) == 1, "Straight against High card")
    }

    func testStraightAgainstThreeOfAKind() {
        XCTAssert(compareHands("2H 3D 4S 5C 6D", "2H 2D 2S 5C 4D") == 1, "Straight against Three Of A Kind")
    }
    
    func testStraightAgainstStrongStraight() {
        XCTAssert(compareHands("2H 3D 4S 5C 6D", "3H 4D 5S 6C 7D") == -1, "Straight against Strong Straight")
    }
    
    //MARK: Flush
    func testFlush() {
        XCTAssert(compareHands("2D 3D 4D 7D 6D", kingHigh) == 1, "Flush against High card")
    }
    
    func testFlushAgainstStraight() {
        XCTAssert(compareHands("2D 3D 4D 7D 6D", "2H 3D 4S 5C 6D") == 1, "Flush Against Straight")
    }
    
    func testFlushAgainstStronger() {
        XCTAssert(compareHands("2D 3D 4D 7D 6D", "2H 4H 5H 6H AH") == -1, "Flush against Stronger Flush")
    }
    
    //
    //    compareHands("2H 3D 5S 9C KD", "2H 3D 5S 9C KH") // 0 - Tie
    //    compareHands("2H 3D 5S 9C KD", "2H 3D 5S 9C AH") // -1 - High Card
    //    compareHands("2H 3D 5S 9C AD", "2H 3D 5S 9C KH") // 1 - High Card
    //    compareHands("2H 3D 5S 9C AD", "2H 3D 5S 9C KH")
    
    
}
