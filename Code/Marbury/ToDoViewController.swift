//
//  ToDoViewController.swift
//  todolist
//
//  Created by Lina Loyko on 10/10/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController{
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var addListButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var buttonsView: UIView!
    @IBOutlet private weak var contentViewHeightConstraint: NSLayoutConstraint!
    private var newItemAlertView: NewItemAlertView!
    private var lists: [ListItem]!
    private var colorButtons: [ListButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListItems()
        loadListsView()
    }
    
    func setAlertView() {
        newItemAlertView = Bundle.main.loadNibNamed("NewItemAlertView", owner: self, options: nil)!.first as? NewItemAlertView
        view.addSubview(newItemAlertView)
        newItemAlertView.center = view.center
    }
    
    private func loadListItems() {
        lists = [ListItem]()
        lists = DataManager.loadWithPrefix(type: ListItem.self, prefix: "list")
        lists.sort(by: {$0.createdAt > $1.createdAt})
    }
    
    private func loadListsView() {
        colorButtons = [ListButton]()
        
        var offsetx = Int()
        var offsety = Int()
        var flag = Int()
        
        for list in lists {
            if flag == 1 {
                offsetx += 175
            } else if flag == 2 {
                offsetx = 0
                offsety += 125
                flag = 0
                contentViewHeightConstraint.constant += 135
                scrollView.contentSize = CGSize(width: 414, height: contentViewHeightConstraint.constant)
            }
            let button = ListButton(type: .custom)
            buttonsView.addSubview(button)
            button.setListButtonWith(color: list.rgbToUIColor())
            button.frame = CGRect(x: offsetx, y: 27 + offsety, width: 165, height: 115)
            button.setTitle(list.title, for: .normal)
            button.addTarget(self, action: #selector(tappedListButton), for: .touchUpInside)
            colorButtons.append(button)
            flag += 1
        }
    }
    
    @objc private func tappedListButton(sender: UIButton) {
        performSegue(withIdentifier: "CategoryTasks", sender: sender)
    }
    
    private func indexOf(selectedButton: ListButton) -> Int {
        var index = 0
        index = colorButtons.firstIndex(of: selectedButton)!
        return index
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryTasks" {
            let todoTableVC = segue.destination as! ToDoListViewController
            todoTableVC.list = lists[indexOf(selectedButton: sender as! ListButton)]
        }
    }
}

