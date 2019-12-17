//
//  ListButton.swift
//  todolist
//
//  Created by Lina Loyko on 11/4/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class ListButton: UIButton {
    
    func setListButtonWith(color: UIColor) {
        switch color {
        case UIColor.getColorFromMyAssets(named: "ButtonColor1"):
            self.setBackgroundImage(UIImage(named: "1"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor2"):
            self.setBackgroundImage(UIImage(named: "2"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor3"):
            self.setBackgroundImage(UIImage(named: "3"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor4"):
            self.setBackgroundImage(UIImage(named: "4"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor5"):
            self.setBackgroundImage(UIImage(named: "5"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor6"):
            self.setBackgroundImage(UIImage(named: "6"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor7"):
            self.setBackgroundImage(UIImage(named: "7"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor8"):
            self.setBackgroundImage(UIImage(named: "8"), for: .normal)
        default:
            self.backgroundColor = .clear
        }
        
        self.titleLabel?.font = UIFont(name: "CormorantSC-Medium", size: 25)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
    }
    
    func getColorFromMyAssets(named: String) -> UIColor {
        let color = UIColor(named: named)!
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    static func getColorFromMyAssets(named: String) -> UIColor {
        let color = UIColor(named: named)!
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
}

