//
//  Theme.swift
//  Concentration
//
//  Created by Leo Vergnetti on 8/16/18.
//  Copyright © 2018 Leo Vergnetti. All rights reserved.
//

import Foundation
import UIKit

struct Theme{
    var emojiChoices = [""]
    var backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var colorOnBackOfCard = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var colorOnFrontOfCard = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    init(emojiChoices : [String], backgroundColor : UIColor, colorOnBackOfCard : UIColor){
        self.emojiChoices = emojiChoices
        self.backgroundColor = backgroundColor
        self.colorOnBackOfCard = colorOnBackOfCard
    }
}
