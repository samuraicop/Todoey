//
//  ViewController.swift
//  Todoey
//
//  Created by Zachary Burgess on 12/20/17.
//  Copyright © 2017 Zachary Burgess. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        
        
        loadItems()
        

        
    }
  
    
    //MARK - [CHALLENGE] - Create TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // new constant
        let item = itemArray[indexPath.row]
        
        // DIFFERENT Way of Expressing Code
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition? valueIfTrue : valueIfFalse
        // set below code to mirror this ^ - Different Way of Expresing Code
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //below line can replace all of the other if else lines below..*? ones commented out if and else..
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)

         }


    
    //MARK - Add New Items ---->>>>> Includes adding a POP-UP Message!!!!
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            //print(textField.text)
            
            
           let newItem = Item()
            newItem.title = textField.text!

            self.itemArray.append(newItem)
            
            self.saveItems()
            
         
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    
}

//MARK = Model Manupulation Methods

func saveItems() {
    let encoder = PropertyListEncoder()

    do {
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
        
        
    } catch {
        print("Error encoding item array, \(error)")
    }
    self.tableView.reloadData()
    
}

func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
        itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item arry, \(error)")
        }
        
        }
    
    }

}
