//
//  EditListViewController.swift
//  todolist
//
//  Created by Lina Loyko on 10/12/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class EditListViewController: ColorButtonsViewController,  UITextFieldDelegate{
    
    @IBOutlet weak var listTitle: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var defaultList: ListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTitle.insertText(defaultList.getTitle())
        selectButton(color: defaultList.rgbToUIColor(), in: colorButtons)
        listTitle.delegate = self
        doRoundButtons(colorButtons)
        deleteButton.layer.cornerRadius = 15
        doneButton.isEnabled = false
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        colorButtonsTapped(colorButtons: colorButtons, sender: sender)
        doneButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if listTitle.text == "" || (listTitle.text == defaultList.getTitle() && selectedButtonColorIn(colorButtons) == defaultList.rgbToUIColor()) {
            doneButton.isEnabled = false
            return true
        } else {
            listTitle.resignFirstResponder()
            doneButton.isEnabled = true
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 40 characters
        return updatedText.count <= 40
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listVC = self.storyboard?.instantiateViewController(withIdentifier: "ToDoListView") as! ToDoListViewController
        
        if segue.identifier == "ListChanged" {
            
            defaultList.resave(title: listTitle.text!, color: selectedButtonColorIn(colorButtons))
            listVC.list = defaultList
            let items = ToDoTableViewController.loadDataByCategory(category: defaultList.getTitle(), createdAt: defaultList.getCreatedAt())
            for item in items {
                item.resave(list: listTitle.text!)
            }
            (segue.destination as! UINavigationController).pushViewController(listVC, animated: true)
        }
        
        if segue.identifier == "DeletedList" {
            let items = ToDoTableViewController.loadDataByCategory(category: defaultList.getTitle(), createdAt: defaultList.getCreatedAt())
            for item in items{
                item.deleteItem()
            }
            defaultList.deleteItem()
        }
        
        if segue.identifier == "CancelEditList" {
            (segue.destination as! UINavigationController).pushViewController(listVC, animated: true)
            listVC.list = defaultList
        }
    }
}
