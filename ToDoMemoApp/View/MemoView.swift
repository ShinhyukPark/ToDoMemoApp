//
//  MemoView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import SwiftUI
import SwiftData

struct MemoView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var memoItems: [MemoItems]
    @State private var isShowingSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.softYellow.ignoresSafeArea()
                VStack{
                    Color.clear
                        .frame(height:0)
                    if memoItems.isEmpty{
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            ButtonView(title: "NEW MEMO")
                        }
                        .sheet(isPresented: $isShowingSheet, content: {
                            AddMemoView()
                        })
                    }else{
                        List {
                            ForEach(memoItems.filter { item in
                                searchText.isEmpty || item.memoTitle.contains(searchText)
                            }) { item in
                                NavigationLink(destination: MemoDetailView(memo: item)) {
                                    Text(item.memoTitle)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                for i in indexSet {
                                    let item = memoItems[i]
                                    modelContext.delete(item)
                                }
                            })
                        }
                        .scrollContentBackground(.hidden)
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            ButtonView(title: "NEW MEMO")
                        }
                        .padding(20)
                        .sheet(isPresented: $isShowingSheet, content: {
                            AddMemoView()
                        })
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Memo")
            .toolbar{
                EditButton()
            }
        }
    }
}

struct ButtonView: View{
    let title: String
    var body: some View{
        Text(title)
            .font(.system(size: 20)).bold()
            .frame(width:200, height: 50)
            .foregroundStyle(Color.white)
            .background {
                RoundedRectangle(cornerRadius: 15).fill(Color("ButtonColor"))
            }
    }
}

struct SaveButtonView: View {
    var body: some View {
        Text("저장")
            .font(.system(size: 20)).bold()
            .frame(width:100, height: 50)
            .foregroundStyle(Color.white)
            .background {
                RoundedRectangle(cornerRadius: 15).fill(Color("ButtonColor"))
            }
            .padding()
    }
}




#Preview {
    MemoView().modelContainer(for:[ToDoItems.self, MemoItems.self])
}
