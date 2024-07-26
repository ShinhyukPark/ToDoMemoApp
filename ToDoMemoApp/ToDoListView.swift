//
//  ToDoList.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/23/24.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var todoItem = ""
    @Query private var todoItems: [ToDoItems]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.softYellow.ignoresSafeArea()
                VStack{
                    HStack {
                        TextField("Add a new task", text: $todoItem)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                        Button {
                            modelContext.insert(ToDoItems(todoItem: todoItem, isChecked: false))
                            todoItem = ""
                        } label: {
                           Text("+")
                                .font(.system(size: 30)).bold()
                                .frame(width:50, height: 50)
                                .foregroundStyle(Color.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 15).fill(Color("ButtonColor"))
                                }
                        }
                        
                    }
                    .padding(.horizontal)
                    List{
                        ForEach(todoItems){ item in
                            HStack {
                                Button {
                                    item.isChecked.toggle()
                                } label: {
                                    Image(systemName: item.isChecked ? "checkmark.square.fill" : "checkmark.square")
                                        .font(.system(size:25))
                                }
                                
                                Text(item.todoItem)
                                    .strikethrough(item.isChecked)
                                    .foregroundStyle(item.isChecked ? Color.gray : Color.black)
                                    .padding(.leading)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            for i in indexSet {
                                let item = todoItems[i]
                                modelContext.delete(item)
                            }
                        })
    //                    .listRowBackground(Color.softYellow)
                    }
                    .scrollContentBackground(.hidden)
                }
                .padding()
            }
            .navigationTitle("ToDoList")
            .toolbar{
                EditButton()
            }
        }
    }
}

#Preview {
    ToDoListView().modelContainer(for:ToDoItems.self)
}
