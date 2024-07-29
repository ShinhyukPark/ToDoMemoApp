//
//  VoiceMemoView.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/28/24.
//

import SwiftUI
import SwiftData
import AVFoundation

struct VoiceMemoView: View {
    
    @StateObject private var voiceMemoManager = VoiceMemoManager()
    @State private var isRecording = false
    @State private var currentlyPlaying: UUID? = nil
    
    @Environment(\.modelContext) private var modelContext
    @Query private var voiceItems:[VoiceItems]

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.softYellow.ignoresSafeArea()
                VStack {
                    List {
                        ForEach(voiceItems) { item in
                                Button(action: {
                                    currentlyPlaying = item.id
                                    voiceMemoManager.playRecording(at: item.voiceItem) {
                                        currentlyPlaying = nil
                                    }
                                }) {
                                    Text("새로운 녹음\(item.number)")
                                        .foregroundStyle(currentlyPlaying == item.id ? .red : .primary)
                                }
                            }
                        .onDelete(perform: { indexSet in
                            for i in indexSet {
                                let item = voiceItems[i]
                                modelContext.delete(item)
                            }
                        })
                    }
                    .scrollContentBackground(.hidden)
                        Button(action: {
                            if isRecording {
                                voiceMemoManager.stopRecording { newRecording in
                                    if let recording = newRecording {
                                        let number = voiceItems.count + 1
                                        let updateRecording = recording
                                        updateRecording.number = number
                                        modelContext.insert(updateRecording)
                                    }
                                }
                            } else {
                                voiceMemoManager.startRecording()
                            }
                            isRecording.toggle()
                        }) {
                            Text(isRecording ? "중지" : "녹음")
                                .font(.system(size: 20)).bold()
                                .padding()
                                .background(isRecording ? Color.red : Color("ButtonColor"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                .padding()
                }
            .navigationTitle("Voice Memo")
            .toolbar{
                EditButton()
            }
            }
        }
    }

#Preview {
    VoiceMemoView()
}
