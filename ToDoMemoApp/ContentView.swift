//
//  ContentView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ToDoListView()
                .tabItem {
                    Image(systemName: "checklist.checked")
                }
            Text("Voice Memo")
                .tabItem {
                    Image(systemName: "waveform")
                }
            MemoView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                }
        }
    }
}

#Preview {
    ContentView().modelContainer(for:[ToDoItems.self, MemoItems.self])
}
