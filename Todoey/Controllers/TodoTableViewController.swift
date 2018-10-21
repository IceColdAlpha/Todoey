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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
//        if let items = defaults.array(forKey: "ToDoListArray") as?[Item] {
//            itemArray = items
//        }

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
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray,forKey: "ToDoListArray")   //Erased this whole line in lecture 227 section 18
            self.saveData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func saveData() {
        
        let encoder = PropertyListEncoder()  //to initialize an incoder SEC. 18 Lec. 227  5:34
        
        do {
            let data = try encoder.encode(self.itemArray)  //to use the initialized encoder ##Because this throws an error we need a do catch block and to mark this method with a try.  ##we are in a closure so the itemArray needs to be marked with a self.  ##Now that we have encoded the data we must write the data to a file path.
            try data.write(to: self.dataFilePath!) //write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loadData () {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
                self.tableView.reloadData()
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    

}

