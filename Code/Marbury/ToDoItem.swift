//
//  ToDoItem.swift
//  todolist
//
//  Created by Lina Loyko on 10/9/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import Foundation
import UIKit

class ToDoItem : Codable {
    private(set) var title : String
    private(set) var list : String
    private(set) var listCreatedAt: Date
    private var completed : Bool
    private(set) var createdAt : Date
    private var itemIdentifier : UUID
    
    init(title: String, list : String, listCreatedAt: Date, completed : Bool, createdAt : Date) {
        self.title = title
        self.list = list
        self.listCreatedAt = listCreatedAt
        self.completed = completed
        self.createdAt = createdAt
        self.itemIdentifier = UUID()
    }
    
    init(title: String, list : String, listCreatedAt: Date) {
        self.title = title
        self.list = list
        self.listCreatedAt = listCreatedAt
        self.completed = false
        self.createdAt = Date()
        self.itemIdentifier = UUID()
    }
    
    func saveItem() {
        DataManager.save(self, with: "item" + itemIdentifier.uuidString)
    }
    
    func resave(list: String) {
        self.list = list
        saveItem()
    }
    
    func deleteItem() {
        DataManager.delete(fileName: "item" + itemIdentifier.uuidString)
    }
    
    func markAsCompleted() {
        self.completed = true
    }
    
    func markAsUncompleted() {
        self.completed = false
    }
    
    func isCompleted() -> Bool {
        return self.completed
    }
}
