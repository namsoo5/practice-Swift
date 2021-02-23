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
    private let session = AVAudioSession.sharedInstance()
    private var player: AVAudioPlayer?
    
    // MARK: - record properties
    private var playerNode: AVAudioPlayerNode! // engine용 player
    private var engine = AVAudioEngine() // 효과
    private var audioFile: AVAudioFile? // 음원파일
    private var buffer: AVAudioPCMBuffer! // 버퍼
    private var recorder: AVAudioRecorder! // 녹음
    
    override init() {
        super.init()
        setSession()
    }
    
    // AudioSession설정 ✅
    func setSession() {
        try? session.setCategory(.playAndRecord, options: [.allowAirPlay,.allowBluetooth,.defaultToSpeaker])
    }
    
    // MARK: - Intent
    // 모델에 음악파일 추가 ✅
    func addAudio<T>(_ audio: T) {
        if audio is Data {
            audioModel.addAudio(audio as! Data)
        } else if audio is URL {
            if let data = try? Data(contentsOf: audio as! URL) {
                audioModel.addAudio(data)
            }
        }
    }
    
    // 음악재생 ✅
    func playAudio(_ audio: AudioModel.Audio) {
        if let index = audios.firstIndex(matching: audio) {
            let data = audios[index].audio
            player = try? AVAudioPlayer(data: data)
            player?.volume = 0.6
            timeCheck(at: index, time: player?.duration)
            player?.play()
        }
    }

    // MARK: - 재생시간
    // 시간 계산 ✅
    private func timeCheck(at index: Int, time: TimeInterval?) {
        if let time = time {
            let sec = String(format: "%02d", Int(floor(time.truncatingRemainder(dividingBy: 60))))
            let min = String(format: "%02d", Int(floor(time / 60)))
            let hour = String(format: "%02d", Int(floor(time / 3600)))
            
            audioModel.audios[index].duration = "\(hour):\(min):\(sec)"
        }
    }
    
    // MARK: - 녹음
    // 녹음 ✅
    func record() {
        do {
            var fileURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            fileURL.append("/testRecord.wav")
            
            recorder = try AVAudioRecorder(url: URL(string: fileURL)!, settings: [:])
            recorder.delegate = self
            try? session.setActive(false)
            try? session.setActive(true)
            recorder.record()
        } catch(let error) {
            print("record error: \(error)")
        }
    }
    
    // 녹음종료 ✅
    func stopRecord() {
        recorder.stop()
        try? session.setActive(false)
        searchRecord()
    }
    
    // 녹음 폴더에 있는 녹음파일 찾아오기 ✅
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
    
    // 기존 음성파일불러오기 ✅
    func setEffectFile() {
        do {
            audioFile = try AVAudioFile(forReading: recorder.url)
            playerNode = AVAudioPlayerNode()
            buffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat,
                                      frameCapacity: AVAudioFrameCount(audioFile!.length))
            try audioFile?.read(into: buffer)
            recordEffect()
        } catch(let error) {
            print(error)
        }
    }
    
    // MARK: - 녹음된파일 변조시키기 ✅
    
    func recordEffect() {
        engine.stop()
        playerNode.stop()
        
        let unitTimePitch = AVAudioUnitTimePitch()
        unitTimePitch.pitch = 1200
        
        let unitEcho = AVAudioUnitDistortion()
        unitEcho.loadFactoryPreset(.multiEcho2)
        
        let unitReverb = AVAudioUnitReverb()
        unitReverb.loadFactoryPreset(.largeHall)
        
        // 재생될 노드 엔진에 추가
        engine.attach(playerNode)
        engine.attach(unitTimePitch)
        engine.attach(unitEcho)
        engine.attach(unitReverb)
        
        // 노드 연결하기
        engine.connect(playerNode, to: unitEcho, format: buffer!.format)
        engine.connect(unitEcho, to: unitTimePitch, format: buffer!.format)
        engine.connect(unitTimePitch, to: unitReverb, format: buffer!.format)
        engine.connect(unitReverb, to: engine.mainMixerNode, format: buffer!.format)
        
        
        if let audioFile = audioFile {
            // 후처리된 음성 준비작업
            playerNode.scheduleBuffer(buffer)
//            playerNode.scheduleFile(audioFile, at: nil)
            
            // 시작
            try? engine.start()
            playerNode.play()
        }
    }
}

extension AudioViewModel: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("녹음완료")
            print(recorder.url)
            setEffectFile()
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
