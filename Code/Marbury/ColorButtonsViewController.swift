//
//  ColorButtonsViewController.swift
//  Marbury
//
//  Created by Lina Loyko on 11/20/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class ColorButtonsViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
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
    }
}
