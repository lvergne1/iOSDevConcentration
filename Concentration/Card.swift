//
//  Card.swift
//  Concentration
//
//  Created by Leo Vergnetti on 8/9/18.
//  Copyright © 2018 Leo Vergnetti. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
