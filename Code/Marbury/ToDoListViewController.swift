//
//  ToDoContainerViewController.swift
//  todolist
//
//  Created by Lina Loyko on 11/3/19.
//  Copyright © 2019 Lina Loyko. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet private weak var container: UIView!
    var list: ListItem!
    private var tableVC: ToDoTableViewController!
    private var newItemAlertView: NewItemAlertView!
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleAndColor()
    }
    
    func setTitleAndColor() {
        self.navigationItem.title = list.title
    }
    
    func setAlertView() {
        newItemAlertView = Bundle.main.loadNibNamed("NewItemAlertView", owner: self, options: nil)!.first as? NewItemAlertView
        newItemAlertView.delegate = self
        
        let window: UIWindow? = UIApplication.shared.keyWindow
        window?.addSubview(newItemAlertView)
        newItemAlertView.center = window!.center
        
    }
    
    func setupVisualEffectView() {
        let window: UIWindow? = UIApplication.shared.keyWindow
        window?.addSubview(visualEffectView)
        visualEffectView.topAnchor.constraint(equalTo: window!.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: window!.bottomAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: window!.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: window!.trailingAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    func animateIn() {
        newItemAlertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        newItemAlertView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 0.3
            self.newItemAlertView.alpha = 1
            self.newItemAlertView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.4,
                       animations: {
                        self.visualEffectView.alpha = 0
                        self.newItemAlertView.alpha = 0
                        self.newItemAlertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.newItemAlertView.removeFromSuperview()
        }
    }
    
    @IBAction private func addNewToDo(_ sender: Any) {
        setupVisualEffectView()
        setAlertView()
        animateIn()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedView" {
            let vc = segue.destination as! ToDoTableViewController
            self.tableVC = vc
            tableVC.list = self.list
        }
        if segue.identifier == "EditList" {
            let editVC = (segue.destination as! UINavigationController).topViewController as! EditListViewController
            editVC.defaultList = list
        }
    }
    
}

// MARK: - Delegate

extension ToDoListViewController: NewItemAlertDelegate {
    func cancelButtonTapped() {
        animateOut()
    }
    
    func createButtonTapped() {
        guard let newTitle = newItemAlertView.getText() else {return}
        animateOut()
        let newToDo = ToDoItem(title: newTitle, list: self.list.title, listCreatedAt: self.list.createdAt)
        newToDo.saveItem()
        self.tableVC.viewWillAppear(true)
    }
}

