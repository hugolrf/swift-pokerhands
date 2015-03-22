//
//  hand.swift
//  pokerhands
//
//  Created by Yonatan Bergman on 3/22/15.
//
//

import Foundation

class Hand{
    let cards:[Card]
    
    init(string: String){
        let cardStrings = split(string) { $0 == " " }
        cards = cardStrings.map { Card(string: $0) }.sorted { $0.strength > $1.strength }
    }
    
    init(cards: [Card]){
        self.cards = cards
    }
    
    func compare(hand: Hand) -> Int {
        let handValue1 = HandValue(hand: self)
        let handValue2 = HandValue(hand: hand)
        return handValue1.compare(handValue2)
    }
    
}