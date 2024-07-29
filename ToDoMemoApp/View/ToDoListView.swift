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
                    .contentShape(Rectangle())
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                VStack{
                    HStack {
                        TextField("Add a new task", text: $todoItem)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                        Button {
                            //빈 텍스트 필드를 추가하지 않도록
                            guard !todoItem.isEmpty else { return }
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
// 바탕을 눌러서 키보드 내리기
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ToDoListView().modelContainer(for:ToDoItems.self)
}
