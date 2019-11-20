//
//  NewItemAlertView.swift
//  todolist
//
//  Created by Lina Loyko on 11/3/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

protocol NewItemAlertDelegate {
    func cancelButtonTapped()
    func createButtonTapped()
}

class NewItemAlertView: UIView {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var delegate: NewItemAlertDelegate?
    
    override func awakeFromNib() {
        createButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
        titleTextField.becomeFirstResponder()
    }
    
    func getText() -> String? {
        return titleTextField.text
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.cancelButtonTapped()
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        if titleTextField.text != "" {
            delegate?.createButtonTapped()
        }
    }
}
