//
//  MemoDetailView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/27/24.
//

import SwiftUI

struct MemoDetailView: View {
    @ObservedObject var memoItems: MemoItems
    let memo : MemoItem
    
    var body: some View {
        ZStack {
            Color.softYellow.ignoresSafeArea()
            VStack(alignment:.leading){
                Text(memo.memoTitle)
                    .padding()
                Divider()
                Text(memo.memoContent)
                    .padding()
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
