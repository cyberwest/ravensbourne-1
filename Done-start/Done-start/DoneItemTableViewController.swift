//
//  DoneItemTableViewController.swift
//  Done-start
//
//  Created by Louise Bishop on 12/12/2016.
//  Copyright © 2016 Louise Bishop. All rights reserved.
//

import UIKit
import Firebase

class DoneItemTableViewController: UITableViewController, DoneAddItemViewControllerDelegate {
    
    /*
     Constants
     Outlets
     Properties
     View lifecycle methods
     Actions
     All other methods
     */
    
    /* #2 Create dummy user data & items for testing */
    let user = User(uid: "fakeID", email: "louise@done.com")

    let ref = FIRDatabase.database().reference(withPath: "to-dos")
    
    
    /* #1 Add an empty ToDoItem Array */
    var items = [ToDoItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Done"
        
        let item1 = ToDoItem(content: "Tidy up HTML", icon: "dev", addedByUser: user.email)
        items.append(item1)
        
        let item2 = ToDoItem(content: "Find somewhere for team lunch", icon: "team", addedByUser: user.email)
        items.append(item2)
        
        /* This stops edit mode from allowing multiple lines to be edited at once */
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #3 Set up number of rows to be displayed
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // #4 Add in cell identifier to use protoype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        // #5 Get reference to the correct item in the items array & set cell properties accordingly
        let item = items[indexPath.row]
        cell.textLabel!.text = item.content
        cell.detailTextLabel!.text = item.addedByUser
        cell.imageView!.image = UIImage(named: item.icon)
        configureCell(cell: cell, item: item)
        
        return cell
    }
    
    // MARK: - Configure Checkmark
    
    // #6 Configure our cell to display each item's checked value - ie add a checkmark
    func configureCell(cell: UITableViewCell, item: ToDoItem) {
        
        if item.checked {
            cell.accessoryType = .checkmark
            cell.textLabel!.textColor = UIColor.gray
            cell.detailTextLabel!.textColor = UIColor.gray
        } else {
            cell.accessoryType = .none
            cell.textLabel!.textColor = UIColor.black
            cell.detailTextLabel!.textColor = UIColor.black
        }
    }
    
    // #7 Use didSelectRowAtIndexPath to add a checkmark to a cell when it is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCell(cell: cell, item: item)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /* To allow rows to be deleted from the tableView, uncomment the methods below */
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // When in delete mode, remove the specified item using the indexPath from the items array & reload the table data
            items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // MARK: Delegate Methods
    
    func addItemViewControllerDidCancel(_ controller: DoneAddItemViewController) {
        navigationController!.popViewController(animated: true)
        
    }
    
    func addItemViewControllerDidSave(_ controller: DoneAddItemViewController, item: ToDoItem) {
        
        //Find the row to add our new item to
        let rowIndex = items.count
        //Create an index path to point to that row
        let indexPath = IndexPath(row: rowIndex, section: 0)
        //Add our new item to the items array
        items.append(item)
        //Insert the item into the table view
        tableView.insertRows(at: [indexPath], with: .fade)
        
        //Create a new to-do item reference
        let toDoItemRef = ref.child(item.content.lowercased())
        toDoItemRef.setValue(item.toAnyObject())
        
        navigationController!.popViewController(animated: true)

        
    }
    
    
    // MARK: - Navigation
    
    /* #13 In order to create a new item, pass the user object forwards.*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addItemViewController = segue.destination as! DoneAddItemViewController
        
        addItemViewController.delegate = self
        
    }
    
    
}
