//
//  Item.swift
//  Todoey
//
//  Created by Zachary Burgess on 1/5/18.
//  Copyright © 2018 Zachary Burgess. All rights reserved.
//

import Foundation

//Class does NOT have to be called 'Item' - but can make it easier to keep track off
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
