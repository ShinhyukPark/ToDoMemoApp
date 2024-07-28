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
//    var container: ModelContainer
//    
//    init() {
//        do{
//            let config1 = ModelConfiguration(for: ToDoItems.self)
//            let congih2 = ModelConfiguration(for: MemoItems.self)
//            
//            container = try ModelContainer(for: ToDoItems.self, MemoItems.self)
//        }catch {
//            fatalError("Failed")
//        }
//    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[ToDoItems.self, MemoItems.self])
    }
}
