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
    
    var allCardsAreMatched : Bool {
        return cards.indices.filter{!cards[$0].isMatched}.count == 0
    }
    
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
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
    
    mutating func shuffleCards(){
        for indexOfFirstCard in 0..<cards.count{
            let copyOfFirstCard = cards[indexOfFirstCard]
            let indexOfSecondCard = Int(arc4random_uniform(UInt32(cards.count)))
            cards[indexOfFirstCard] = cards[indexOfSecondCard]
            cards[indexOfSecondCard] = copyOfFirstCard
        }
    }
    mutating func nextLevel(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].wasPreviouslyShown = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        shuffleCards()
        flipCount = 0
    }
    mutating func newGame(){
        score = 0
        nextLevel()
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
}
//TODO: Timer Score Bonus
extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

