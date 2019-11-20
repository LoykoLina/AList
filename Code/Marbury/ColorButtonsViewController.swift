//
//  ColorButtonsViewController.swift
//  Marbury
//
//  Created by Lina Loyko on 11/20/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class ColorButtonsViewController: UIViewController {
    
    func doRoundButtons(_ colorButtons: [UIButton]){
        for button in colorButtons {
            button.layer.cornerRadius = button.bounds.size.width * 0.5
        }
    }
    
    func colorButtonsTapped(colorButtons: [UIButton], sender: UIButton) {
        sender.showsTouchWhenHighlighted = true
        sender.layer.borderWidth = 4.5
        
        for button in colorButtons {
            if button != sender {
                button.layer.borderWidth = 1.5
            }
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowOpacity = 0.7
            button.layer.shadowRadius = 7.0
        }
    }
    
    func selectedButtonColorIn(_ colorButtons: [UIButton]) -> UIColor {
        for button in colorButtons {
            if button.layer.borderWidth == 4.5 {
                return button.backgroundColor!
            }
        }
        return UIColor.black
    }
    
    func selectButton(color: UIColor, in colorButtons: [UIButton]){
        for button in colorButtons {
            if button.backgroundColor == color {
                colorButtonsTapped(colorButtons: colorButtons, sender: button)
                break
            }
        }
        
        switch color {
        case UIColor.getColorFromMyAssets(named: "ButtonColor1"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[0])
        case UIColor.getColorFromMyAssets(named: "ButtonColor2"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[1])
        case UIColor.getColorFromMyAssets(named: "ButtonColor3"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[2])
        case UIColor.getColorFromMyAssets(named: "ButtonColor4"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[3])
        case UIColor.getColorFromMyAssets(named: "ButtonColor5"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[4])
        case UIColor.getColorFromMyAssets(named: "ButtonColor6"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[5])
        case UIColor.getColorFromMyAssets(named: "ButtonColor7"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[6])
        case UIColor.getColorFromMyAssets(named: "ButtonColor8"):
            colorButtonsTapped(colorButtons: colorButtons, sender: colorButtons[7])
        default:
            return
        }
    }
}
