//
//  Concentration.swift
//  Concentration
//
//  Created by Leo Vergnetti on 8/9/18.
//  Copyright © 2018 Leo Vergnetti. All rights reserved.
//

import Foundation

struct Concentration
{
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    mutating func chooseCard(at index: Int){
        if !cards[index].isMatched{
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if cards[matchIndex].wasPreviouslyShown{
                        score -= 1
                    }
                    if cards[index].wasPreviouslyShown{
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                cards[index].wasPreviouslyShown = true
                cards[matchIndex].wasPreviouslyShown = true
            } else {
                //either no cards or 2 cards are faceUp
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle the cards
        for indexOfFirstCard in 0..<cards.count{
            let copyOfFirstCard = cards[indexOfFirstCard]
            let indexOfSecondCard = Int(arc4random_uniform(UInt32(cards.count)))
            cards[indexOfFirstCard] = cards[indexOfSecondCard]
            cards[indexOfSecondCard] = copyOfFirstCard
        }
    }
    
    init(numberOfPairsOfCards: Int, score: Int){
        self.init(numberOfPairsOfCards: numberOfPairsOfCards)
        self.score = score
    }
}

