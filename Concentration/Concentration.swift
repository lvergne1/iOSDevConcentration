//
//  Concentration.swift
//  Concentration
//
//  Created by Leo Vergnetti on 8/9/18.
//  Copyright © 2018 Leo Vergnetti. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are faceUp
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle the cards
        for index in 0..<cards.count{
            let cardCopyToBeOverwritten = cards[index]
            let swapIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards[index] = cards[swapIndex]
            cards[swapIndex] = cardCopyToBeOverwritten
        }
    }
}
