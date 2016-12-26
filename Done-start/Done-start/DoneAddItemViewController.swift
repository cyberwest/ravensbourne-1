//
//  DoneAddItemViewController.swift
//  Done-start
//
//  Created by Louise Bishop on 12/12/2016.
//  Copyright © 2016 Louise Bishop. All rights reserved.
//

import UIKit

/* #11 Creating a protocol - in order to pass objects back to the DoneTableViewController, use the delegate/protocol pattern. The protocol defines the methods that the delegate will respond to, and must be declared outside the class. */

protocol DoneAddItemViewControllerDelegate : class {
    func addItemViewControllerDidSave(_ controller: DoneAddItemViewController, item: ToDoItem)
    func addItemViewControllerDidCancel(_ controller: DoneAddItemViewController)
}


class DoneAddItemViewController: UIViewController {
    
    @IBOutlet weak var addItemTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    /* #12 Create an empty delegate property that will hold whichever controller assigns itself as the delegate */
    weak var delegate : DoneAddItemViewControllerDelegate?
    
    var iconSelected = "team"
    var user = User(uid: "", email: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /* #9 Add a save button method that creates a new item from the textfield & segmented control */
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        /* Create a new tod do item */
        let item = ToDoItem(content: addItemTextField.text!, icon: iconSelected, addedByUser: user.email)
        
        /*Send this item back to the table view */
        delegate?.addItemViewControllerDidSave(self, item: item)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        delegate?.addItemViewControllerDidCancel(self)
        
    }
    
    
    /* #10 Add a segementChanged method that monitors the value of the segemented control & updates the iconSelected property accordingly */
    @IBAction func segmentChanged() {
        
    }

    
    
}
