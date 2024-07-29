//
//  ToDoMemoAppApp.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/23/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoMemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[ToDoItems.self, MemoItems.self, VoiceItems.self])
    }
}
