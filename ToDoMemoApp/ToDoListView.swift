//
//  ToDoList.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/23/24.
//

import SwiftUI

struct ToDoListView: View {
    
    @State private var todoItem = ""
    
    var body: some View {
        ZStack {
            Color("SoftYellow").ignoresSafeArea()
            VStack{
                TextField("Add a new task", text: $todoItem)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
            }
            .padding()
        }
    }
}

#Preview {
    ToDoListView()
}
