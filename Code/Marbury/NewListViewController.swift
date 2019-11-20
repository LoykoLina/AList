//
//  NewListViewController.swift
//  todolist
//
//  Created by Lina Loyko on 10/11/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class NewListViewController: ColorButtonsViewController, UITextFieldDelegate {

    @IBOutlet weak var listTitle: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet var colorButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doRoundButtons(colorButtons)
        doneButton.isEnabled = false
        selectButton(color: colorButtons[2].backgroundColor!, in: colorButtons)
        
        listTitle.delegate = self
        listTitle.becomeFirstResponder()
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        colorButtonsTapped(colorButtons: colorButtons, sender: sender)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if listTitle.text != ""{
            doneButton.isEnabled = true
            listTitle.resignFirstResponder()
            return true
        } else {
            doneButton.isEnabled = false
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 16 characters
        return updatedText.count <= 40
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewList"{
            let list = ListItem(title: listTitle.text!, color: selectedButtonColorIn(colorButtons), createdAt: Date())
            list.saveItem()
        }
    }
    
}
