//
//  ViewController.swift
//  Concentration
//
//  Created by Leo Vergnetti on 8/8/18.
//  Copyright © 2018 Leo Vergnetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = themeChoices[Int(arc4random_uniform(UInt32(themeChoices.count)))]
        updateViewFromModel()
    }
    func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    let themeChoices = [["👻","😈","🎃","😱","💀","🧟‍♂️","🍎","🌕","🦇","🍭"],["🤶","🎄","🎅","🎁","😇","👼","⭐️","☃️"],["😀","😅","😂","🙂","🧐","🤓","☹️","😖","🤬","😨","😤"]]
    
    lazy var emojiChoices = themeChoices[Int(arc4random_uniform(UInt32(themeChoices.count)))]
   
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
       return emoji[card.identifier] ?? "?"
    }
}

