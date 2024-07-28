//
//  MemoDetailView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import SwiftUI
import SwiftData

struct MemoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let memo : MemoItems
    @State private var title: String
    @State private var content: String
    
    init(memo: MemoItems) {
        self.memo = memo
        _title = State(initialValue: memo.memoTitle)
        _content = State(initialValue: memo.memoContent)
    }
    
    var body: some View {
        ZStack {
            Color.softYellow.ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            VStack(alignment:.leading){
                TextEditor(text: $title)
                    .frame(height: 31)
                    .padding()
                    .scrollContentBackground(.hidden)
                Divider()
                TextEditor(text: $content)
                    .scrollContentBackground(.hidden)
                    .padding()
                Spacer()
                Button {
                    memo.memoTitle = title
                    memo.memoContent = content
                } label: {
                    Text("저장")
                        .font(.system(size: 20)).bold()
                        .frame(width:100, height: 50)
                        .foregroundStyle(Color.white)
                        .background {
                            RoundedRectangle(cornerRadius: 15).fill(Color("ButtonColor"))
                        }
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

