//
//  MemoView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import SwiftUI

struct MemoView: View {
    
    @StateObject private var memoModel = MemoItems()
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.softYellow.ignoresSafeArea()
                VStack{
                    if memoModel.memoItems.isEmpty{
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            Text("NEW MEMO")
                                .font(.system(size: 20)).bold()
                                .frame(width:200, height: 50)
                                .foregroundStyle(Color.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 15).fill(Color("ButtonColor"))
                                }
                        }
                        .sheet(isPresented: $isShowingSheet, content: {
                            AddMemoView(memoItems: memoModel)
                        })
                    }else{
                        List {
                            ForEach(memoModel.memoItems) { item in
                                NavigationLink(destination: MemoDetailView(memoItems: memoModel, memo: item)) {
                                    Text(item.memoTitle)
                                }
                            }
                            .onDelete(perform: memoModel.deleteMemo)
                        }
                        .scrollContentBackground(.hidden)
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            Text("NEW MEMO")
                                .font(.system(size: 20)).bold()
                                .frame(width:200, height: 50)
                                .foregroundStyle(Color.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 15).fill(Color("ButtonColor"))
                                }
                        }
                        .sheet(isPresented: $isShowingSheet, content: {
                            AddMemoView(memoItems: memoModel)
                        })
                    }
                }
                .padding()
            }
            .navigationTitle("Memo")
            .toolbar{
                EditButton()
            }
        }
    }
}

#Preview {
    MemoView()
}
