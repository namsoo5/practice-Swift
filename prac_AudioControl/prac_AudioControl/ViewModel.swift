//
//  ViewModel.swift
//  prac_AudioControl
//
//  Created by 남수김 on 2021/02/15.
//

import SwiftUI
import AVFoundation

class AudioViewModel: NSObject, ObservableObject {
    @Published private var audioModel: AudioModel = AudioModel()
    var audios: [AudioModel.Audio] { audioModel.audios }
    private var player: AVAudioPlayer?
    
    // MARK: - record properties
    private var playerNode = AVAudioPlayerNode()
    private var engine = AVAudioEngine() // 효과
    private var audioFile: AVAudioFile? // 음원파일
    private var buffer: AVAudioPCMBuffer! // 버퍼
    private var recorder: AVAudioRecorder! // 녹음
    
    // MARK: - Intent
    
    func addAudio<T>(_ audio: T) {
        if String(describing: audio.self) == String(describing: Data.self) {
            audioModel.addAudio(audio as! Data)
        } else {
            if let data = try? Data(contentsOf: audio as! URL) {
                audioModel.addAudio(data)
            }
        }
        
    }
    
    func playAudio(_ audio: AudioModel.Audio) {
        if let index = audios.firstIndex(matching: audio) {
            let data = audios[index].audio
            player = try? AVAudioPlayer(data: data)
            timeCheck(at: index, time: player?.duration)
            player?.play()
        }
    }

    // MARK: - 재생시간
    
    private func timeCheck(at index: Int, time: TimeInterval?) {
        if let time = time {
            let sec = String(format: "%02d", Int(floor(time.truncatingRemainder(dividingBy: 60))))
            let min = String(format: "%02d", Int(floor(time / 60)))
            let hour = String(format: "%02d", Int(floor(time / 3600)))
            
            audioModel.audios[index].duration = "\(hour):\(min):\(sec)"
        }
    }
    
    //rate: Float, itch: Float, echo: Bool, reverb: Bool
    // MARK: - 녹음된파일 변조시키기
    
    func recordEffect() {
        
        let unitTimePitch = AVAudioUnitTimePitch()
        unitTimePitch.pitch = 1200
        
        let unitEcho = AVAudioUnitDistortion()
        unitEcho.loadFactoryPreset(.multiEcho1)
        
        let unitReverb = AVAudioUnitReverb()
        unitReverb.loadFactoryPreset(.largeHall)
        
        engine.attach(playerNode)
        engine.attach(unitTimePitch)
        engine.attach(unitEcho)
        engine.attach(unitReverb)
        
        engine.connect(playerNode, to: engine.mainMixerNode, format: buffer!.format)
        
        
        playerNode.stop()
        if let audioFile = audioFile {
            playerNode.scheduleFile(audioFile, at: nil) {
                print("scheduleFile")
            }
        }
            
        try? engine.start()
        playerNode.play()
    }
    
//    func setAudioFile() {
//        var fileURL = try FileManager.default.url(for: .documentDirectory,
//                                                  in: .userDomainMask,
//                                                  appropriateFor: nil,
//                                                  create: true)
//        fileURL.append("/testRecord.mp3")
//        print(fileURL)
//        audioFile = try AVAudioFile(forReading: URL(string: fileURL)!)
//
//        buffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat,
//                                  frameCapacity: AVAudioFrameCount(audioFile!.length))
//        try audioFile?.read(into: buffer)
//    }
    
    // MARK: - 녹음
    func record() {
        do {
            var fileURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            fileURL.append("/testRecord.wav")
            
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord)
            recorder = try AVAudioRecorder(url: URL(string: fileURL)!, settings: [:])
            recorder.delegate = self
            try? session.setActive(true)
            recorder.record()
        } catch(let error) {
            print("record error: \(error)")
        }
    }
    
    func stopRecord() {
        recorder.stop()
        try? AVAudioSession.sharedInstance().setActive(false)
        searchRecord()
    }
    
    // 녹음 폴더에 있는 녹음파일 찾아오기
    func searchRecord() {
        let urlString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(urlString)
        if let urls = try? FileManager.default.subpathsOfDirectory(atPath: urlString) {
            for path in urls {
                print("\(urlString)/\(path)")
                addAudio(URL(string: "file://\(urlString)/\(path)")!)
            }
        }
    }
    
    func setEffectFile() {
        do {
            audioFile = try AVAudioFile(forReading: recorder.url)
            buffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat,
                                      frameCapacity: AVAudioFrameCount(audioFile!.length))
            
        } catch(let error) {
            print(error)
        }
    }
}

extension AudioViewModel: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("녹음완료")
            print(recorder.url)
        } else {
            print("녹음실패")
        }
    }
}

extension Collection where Element: Identifiable {
    func firstIndex(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
}
