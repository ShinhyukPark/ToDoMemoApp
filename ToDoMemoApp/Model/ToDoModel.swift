//
//  ToDoModel.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/26/24.
//

import Foundation
import SwiftData

@Model
class ToDoItems: Identifiable,Hashable {
    let id = UUID()
    var todoItem: String
    var isChecked: Bool
    
    init(todoItem: String, isChecked: Bool) {
        self.todoItem = todoItem
        self.isChecked = isChecked
    }
}

