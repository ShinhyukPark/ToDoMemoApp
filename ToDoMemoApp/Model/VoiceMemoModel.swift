//
//  VoiceMemoModel.swift
//  ToDoMemoApp
//
//  Created by Shinhyuk Park on 7/28/24.
//

import Foundation
import AVFoundation
import SwiftData

class VoiceMemoManager: NSObject, ObservableObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    private var onFinishRecording: ((VoiceItems?) -> Void)?

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]
            
            let url = getDocumentsDirectory().appendingPathComponent("recording_\(Date().timeIntervalSince1970).m4a")
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
        } catch {
            onFinishRecording?(nil)
        }
    }
    
    func stopRecording(onFinish: @escaping (VoiceItems?) -> Void) {
        audioRecorder?.stop()
        let url = audioRecorder?.url
        audioRecorder = nil
        self.onFinishRecording = onFinish
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch {
        }
        
        if let url = url {
            onFinishRecording?(VoiceItems(voiceItem: url, number: -1))
        } else {
            onFinishRecording?(nil)
        }
    }
    
    func playRecording(at url: URL, completion: @escaping () -> Void) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + audioPlayer!.duration) {
                completion()
            }
        } catch {
            completion()
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

@Model
class VoiceItems{
    let id = UUID()
    var voiceItem: URL
    var number: Int
    
    init(voiceItem: URL, number: Int) {
        self.voiceItem = voiceItem
        self.number = number
    }
}
