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
//    var modelBudle: [MemoItems]
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
    }
}

//#Preview{
//    AddMemoView().modelContainer(for:[ToDoItems.self, MemoItems.self])
//}
