//
//  Item.swift
//  Done-start
//
//  Created by Louise Bishop on 12/12/2016.
//  Copyright © 2016 Louise Bishop. All rights reserved.
//

import Foundation

class ToDoItem {
    
    let content : String
    let icon : String
    let addedByUser : String
    var checked = false
    var key : String
    
    init(key: String = "", content: String, icon: String, addedByUser: String) {
        self.content = content
        self.icon = icon
        self.addedByUser = addedByUser
        self.key = key
    }
    
    
    // #8 Add a method that changes the value of checked
    func toggleChecked() {
        checked = !checked
    }
    
    func toAnyObject() -> [String:AnyObject] {
        return [
       "content": content as AnyObject,
       "checked": checked as AnyObject,
            "icon": icon as AnyObject,
            "addedByUser": addedByUser as AnyObject
        ]
    }
    
}
