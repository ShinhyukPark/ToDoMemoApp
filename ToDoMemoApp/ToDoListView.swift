//
//  ToDoList.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/23/24.
//

import SwiftUI

struct ToDoListView: View {
    
    @State private var isChecked = false
    @State private var todoItem = ""
    @State private var items: [String] = []
    
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
                            items.append(todoItem)
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
                        ForEach(items, id: \.self){ item in
                            HStack {
                                Text(item)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            items.remove(atOffsets: indexSet)
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
    ToDoListView()
}
