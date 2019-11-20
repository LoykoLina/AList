//
//  ToDoTableViewController.swift
//  todolist
//
//  Created by Lina Loyko on 10/9/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var list: ListItem!
    var toDoItems: [ToDoItem]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodoItems()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 70
        return UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTodoItems()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        for item in toDoItems {
            if item.isCompleted() {
                item.deleteItem()
            }
        }
    }
    
    func loadTodoItems() {
        toDoItems = [ToDoItem]()
        toDoItems = ToDoTableViewController.loadDataByCategory(category: list.getTitle(), createdAt: list.getCreatedAt())
        toDoItems.sort(by: {$0.getCreatedAt() < $1.getCreatedAt()})
        tableView.reloadData()
    }
    
    static func loadDataByCategory(category: String, createdAt: Date) -> [ToDoItem] {
        let items = DataManager.loadWithPrefix(type: ToDoItem.self, prefix: "item")
        var finalItems = [ToDoItem]()
        for item in items {
            if item.getList() == category && item.getListCreatedAt() == createdAt {
                finalItems.append(item)
            }
        }
        return finalItems
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        cell.delegate = self
        
        // Configure the cell...
        let toDoItem = toDoItems[indexPath.row]
        cell.toDoLabel.text = toDoItem.getTitle()
        
        cell.setButton(item: toDoItem, listColor: list.rgbToUIColor())
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {(action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            self.toDoItems[indexPath.row].deleteItem()
            self.toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        return [deleteAction]
    }
}

extension ToDoTableViewController: ToDoCellDelegate {
    
    func didRequestComplete(_ cell: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let todoItem = toDoItems[indexPath.row]
            
            switch todoItem.isCompleted() {
            case true:
                todoItem.markAsUncompleted()
                cell.toDoLabel.textColor = .black
                cell.setButton(item: todoItem, listColor: list.rgbToUIColor())
            case false:
                todoItem.markAsCompleted()
                cell.toDoLabel.textColor = .gray
                cell.setButton(item: todoItem, listColor: list.rgbToUIColor())
            }
        }
    }
}
