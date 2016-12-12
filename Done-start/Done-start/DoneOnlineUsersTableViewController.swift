//
//  DoneOnlineUsersTableViewController.swift
//  Done-start
//
//  Created by Louise Bishop on 12/12/2016.
//  Copyright © 2016 Louise Bishop. All rights reserved.
//

import UIKit

class DoneOnlineUsersTableViewController: UITableViewController {
    
    /*Add a property to hold the users for this controller*/
    /*Create a user in a constant*/
    /*Add this user to the currentUsers array*/
    /*Set up the tableView data source*/
    /*Show the email associated with the user in the cell*/
    
    let user = User(uid: "fakeID", email: "test@done.com")
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        users.append(user)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel!.text = user.email
        
        return cell
    }
    
}
