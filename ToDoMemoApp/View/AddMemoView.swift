//
//  AddMemoView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import SwiftUI
import SwiftData

struct AddMemoView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var title = ""
    @State private var content = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.softYellow.ignoresSafeArea()
            VStack{
                TextField(text: $title) {
                    Text("제목")
                }
                .padding()
                Divider()
                ZStack(alignment:.leading){
                    //플레이스홀더
                    if content.isEmpty {
                        VStack{
                            Text("내용")
                                .padding()
                                .padding(.top, 10)
                                .opacity(0.2)
                            Spacer()
                        }
                    }
                    TextEditor(text: $content)
                        .scrollContentBackground(.hidden)
                    .padding()
                }
                Spacer()
                Button {
                    modelContext.insert(MemoItems(memoTitle: title, memoContent: content))
                    dismiss()
                } label: {
                    SaveButtonView()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .padding()
        }
    }
}
