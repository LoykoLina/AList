//
//  DataManager.swift
//  todolist
//
//  Created by Lina Loyko on 10/9/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import Foundation

public class DataManager{
    
    //get document directory
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Can not access document directory")
        }
    }
    
    //save any kind of codable object
     static func save <T:Encodable>(_ object: T, with fileName: String) {
        let url = DataManager.getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false) //url of a file we gonna save
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object) //creates JSON representation of data model
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    //load any kind of codable object
    static func load <T : Decodable>(fileName: String, with type: T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    //load files from a directory by category
    static func loadWithPrefix <T: Decodable>(type: T.Type, prefix: String) -> [T] {
        do{
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            var modelObjects = [T]()
            
            for fileName in files{
                if fileName.hasPrefix(prefix){
                    let itemData = load(fileName: fileName, with: type)
                    modelObjects.append(itemData)
                }
            }
            return modelObjects
        } catch {
            fatalError("Could not load any files")
        }
    }
    
    //delete a file
    static func delete(fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
