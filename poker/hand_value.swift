//
//  hand_value.swift
//  poker
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 Yonatan Bergman. All rights reserved.
//

import Foundation

class HandValue {
    enum HandRank: Int{
        case HighCard, Pair, TwoPair, ThreeOfAKind, Straight, Flush
    }
    
    typealias HandValueParams = (HandRank, [Int], [Int])
    
    let hand:Hand
    let rank:HandRank = .HighCard
    let values:[Int] = []
    let kickers:[Int] = []
    
    init(hand:Hand){
        self.hand = hand
        (self.rank, self.values, self.kickers) = parseFlush() ??
                                                 parseStraight() ??
                                                 parseThreeOfAKind() ??
                                                 parseTwoPair() ??
                                                 parsePair() ??
                                                 parseHighCard()
    }
    
    func compare(other:HandValue) -> Int{
        if self.rank.rawValue > other.rank.rawValue { return 1 }
        else if self.rank.rawValue < other.rank.rawValue { return -1 }
        else {
            let arr1 = self.values + self.kickers
            let arr2 = other.values + other.kickers
            for i in 0..<arr1.count {
                if arr1[i] > arr2[i] { return 1 }
                else if arr1[i] < arr2[i] { return -1 }
            }
            return 0
        }
    }
    
    func parseFlush() -> HandValueParams? {
        if isFlush() {
            return (.Flush, sortedHandStrengths(), [])
        } else {
            return nil
        }
    }
    
    func isFlush() -> Bool {
        for i in 1..<hand.cards.count {
            if hand.cards[i-1].suit != hand.cards[i].suit{
                return false
            }
        }
        return true
    }
    
    func parseStraight() -> HandValueParams? {
        if isStraight() {
            return (.Straight, sortedHandStrengths(), [])
        } else {
            return nil
        }
    }
    
    func isStraight() -> Bool {
        let values = sortedHandStrengths()
        for i in 1..<values.count {
            if values[i-1] - 1 != values[i]{
                return false
            }
        }
        return true
    }
    
    func parseThreeOfAKind() -> HandValueParams?{
        return parseXOfAKind(3, rank: .ThreeOfAKind)
    }
    
    func parseTwoPair() -> HandValueParams?{
        if let pairValues = twoPair() {
            return (.TwoPair, pairValues, sortedHandStrengths().filter{ !contains(pairValues, $0) })
        } else {
            return nil
        }
    }
    
    func parsePair() -> HandValueParams?{
        return parseXOfAKind(2, rank: .Pair)
    }
    
    func parseXOfAKind(x: Int, rank: HandRank) -> HandValueParams? {
        if let xValue = XOfAKind(x) {
            return (rank, [xValue], sortedHandStrengths().filter{ $0 != xValue })
        } else {
            return nil
        }
    }
    
    func parseHighCard() -> HandValueParams{
        return (.HighCard, sortedHandStrengths(), [])
    }
    
    func sortedHandStrengths() -> [Int]{
        return hand.cards.map{ $0.strength }.sorted(>)
    }
    
    private func twoPair() -> [Int]? {
        var twoPairStrengths:[Int] = []
        for (strength, count) in self.group() {
            if count == 2 {
                twoPairStrengths.append(strength)
            }
        }
        return twoPairStrengths.count == 2 ? twoPairStrengths.sorted(>) : nil;
    }
    
    private func XOfAKind(x: Int) -> Int? {
        for (strength, count) in self.group() {
            if count == x {
                return strength
            }
        }
        return nil
    }
    
    private func group() -> [Int: Int]{
        var grouping:[Int: Int] = [:]
        for card in hand.cards {
            var cnt = grouping[card.strength] ?? 0
            grouping[card.strength] = cnt + 1
        }
        return grouping
    }


}
