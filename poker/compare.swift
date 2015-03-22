//
//  compare.swift
//  poker
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 Yonatan Bergman. All rights reserved.
//

import Foundation

infix operator <=> {}

func <=> (left:Int, right:Int) -> Int {
    return left == right ? 0 : left > right ? 1 : -1
}
