//
//  card.swift
//  pokerhands
//
//  Created by Yonatan Bergman on 3/22/15.
//
//

import Foundation

class Card{
    let strength:Int
    let suit:Character
    
    init(string:String) {
        strength = Card.convertStrength(string[string.startIndex])
        suit = string[string.startIndex.successor()]
    }
    
    class func convertStrength(char:Character) -> Int {
        switch (char){
        case "A":
            return 14
        case "K":
            return 13
        case "Q":
            return 12
        case "J":
            return 11
        case "T":
            return 10
        default:
            return String(char).toInt() ?? 0
        }
    }
}