//
//  ToDoListItem.swift
//  todolist
//
//  Created by Lina Loyko on 10/16/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import Foundation
import UIKit

class ListItem: Codable{
    
    private(set) var title: String
    private var red: CGFloat = 0
    private var green: CGFloat = 0
    private var blue: CGFloat = 0
    private var alpha: CGFloat = 0
    private(set) var createdAt: Date
    private var identifier: UUID
    
    init(title: String, color: UIColor, createdAt: Date) {
        self.title = title
        self.createdAt = createdAt
        self.identifier = UUID()
        UIColorToRGB(color: color)
    }
    
    func saveItem() {
        DataManager.save(self, with: "list" + identifier.uuidString)
    }
    
    func deleteItem() {
        DataManager.delete(fileName: "list" + identifier.uuidString)
    }
    
    func rgbToUIColor() -> UIColor {
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func UIColorToRGB(color: UIColor) {
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
    func resave(title: String, color: UIColor) {
        self.title = title
        UIColorToRGB(color: color)
        saveItem()
    }
}
