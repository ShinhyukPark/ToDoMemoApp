//
//  MemoModel.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import Foundation
import SwiftData

@Model
class MemoItems{
    let id = UUID()
    var memoTitle = ""
    var memoContent = ""
    
    init(memoTitle: String = "", memoContent: String = "") {
        self.memoTitle = memoTitle
        self.memoContent = memoContent
    }
}

