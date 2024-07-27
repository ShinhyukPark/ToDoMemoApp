//
//  MemoModel.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import Foundation

class MemoItems: ObservableObject {
    @Published var memoItems: [MemoItem] = []
    
    func addMemo(title: String, content: String) {
        let newMemo = MemoItem(memoTitle: title, memoContent: content)
        memoItems.append(newMemo)
    }
    
    func deleteMemo(at offsets: IndexSet) {
        memoItems.remove(atOffsets: offsets)
    }
}

struct MemoItem: Identifiable, Hashable {
    let id = UUID()
    var memoTitle = ""
    var memoContent = ""
}
