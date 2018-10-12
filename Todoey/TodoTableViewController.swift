//
//  ViewController.swift
//  Todoey
//
//  Created by jamel thomas on 10/12/18.
//  Copyright © 2018 Jamel Thomas. All rights reserved.
// Just testing something out

import UIKit

class TodoTableViewController: UITableViewController {
    let defaults = UserDefaults.standard  //Use this for persistent data
    
    var itemArray = ["I win1","I win2","I win3"]
    override func viewDidLoad() {
        if let items = defaults.array(forKey: "ToDoListArray") as?[String] {
            itemArray = items
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK - TableViewDataSource Methods Needed
    //TODO
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true) //Adds effect of cell being selected then back to original color
       
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {  //Adds checkmark or takes it away when cell is selected
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    //MARK - UIButton Action
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "I dunno why she didn't show this ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray,forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

