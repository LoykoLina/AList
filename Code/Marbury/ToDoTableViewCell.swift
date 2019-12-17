//
//  ToDoTableViewCell.swift
//  todolist
//
//  Created by Lina Loyko on 10/9/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate {
    func didRequestComplete(_ cell : ToDoTableViewCell)
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    var delegate: ToDoCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkButton.isUserInteractionEnabled = true
        checkButton.isMultipleTouchEnabled = true
        checkButton.showsTouchWhenHighlighted = true
    }

    @IBAction func completeToDo(_ sender: UIButton) {
        if let delegateObgect = self.delegate{
            delegateObgect.didRequestComplete(self)
        }
    }
    
    func setButton(item: ToDoItem, listColor: UIColor) {
        switch listColor {
        case UIColor.getColorFromMyAssets(named: "ButtonColor1"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked1" : "unchecked1"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor2"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked2" : "unchecked2"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor3"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked3" : "unchecked3"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor4"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked4" : "unchecked4"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor5"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked5" : "unchecked5"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor6"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked6" : "unchecked6"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor7"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked7" : "unchecked7"), for: .normal)
        case UIColor.getColorFromMyAssets(named: "ButtonColor8"):
            checkButton.setImage(UIImage(named: item.isCompleted() ? "checked8" : "unchecked8"), for: .normal)
        default:
            checkButton.backgroundColor = .clear
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        //self.contentView.backgroundColor = .white
    }
}
