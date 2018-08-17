//
//  ViewController.swift
//  Concentration
//
//  Created by Leo Vergnetti on 8/8/18.
//  Copyright © 2018 Leo Vergnetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = configureNewGame()
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func configureNewGame() -> Concentration{
        currentTheme = themeChoices[Int(arc4random_uniform(UInt32(themeChoices.count)))]
        emojiChoices = currentTheme.emojiChoices
        self.view.backgroundColor = currentTheme.backgroundColor
        newGameButton.backgroundColor = currentTheme.colorOnBackOfCard
        newGameButton.setTitleColor(currentTheme.backgroundColor, for: UIControlState.normal)
        scoreLabel.textColor = currentTheme.colorOnBackOfCard
        flipCountLabel.textColor = currentTheme.colorOnBackOfCard
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        return game
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        game = configureNewGame()
    }
    private func updateViewFromModel(){
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : currentTheme.colorOnBackOfCard            }
        }
    }
    
    private var themeChoices = [Theme(emojiChoices: ["👻","😈","🎃","😱","💀","🧟‍♂️","🍎","🌕","🦇","🍭"], backgroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorOnBackOfCard : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)), Theme(emojiChoices: ["🤶","🎄","🎅","🎁","😇","👼","⭐️","☃️"], backgroundColor : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), colorOnBackOfCard : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Theme(emojiChoices: ["😀","😅","😂","🙂","🧐","🤓","☹️","😖","🤬","😨","😤"], backgroundColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), colorOnBackOfCard: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1))]
    
    
    private lazy var currentTheme = themeChoices[Int(arc4random_uniform(UInt32(themeChoices.count)))]
    private lazy var emojiChoices = currentTheme.emojiChoices
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
       return emoji[card.identifier] ?? "?"
    }
}

