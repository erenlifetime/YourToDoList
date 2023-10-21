//
//  Item.swift
//  toDoList
//
//  Created by Eren lifetime on 21.10.2023.
//

import Foundation
import RealmSwift
class Item:Category{
    
@objc dynamic var name:String = ""
@objc dynamic var done:Bool = false
@objc dynamic var dateCreated:Date?
    var parentCategory = LinkingObjects(fromType:Category.self,property:"items")
}

