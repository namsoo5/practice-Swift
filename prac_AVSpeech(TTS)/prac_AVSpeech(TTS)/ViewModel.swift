//
//  ViewModel.swift
//  prac_AVSpeech(TTS)
//
//  Created by 남수김 on 2021/02/23.
//

import AVFoundation

class ViewModel: NSObject {
    let speech = AVSpeechSynthesizer()
    var voice: AVSpeechSynthesisVoice!
    var utterance: AVSpeechUtterance!
    
    override init() {
        super.init()
        speech.delegate = self
    }
    func setText(_ s: String) {
        utterance = AVSpeechUtterance(string: s)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speakVoice()
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .allowBluetooth)
    }
    
    func speakVoice() {
        speech.speak(utterance)
    }
}

extension ViewModel: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("speak")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print(characterRange)
        print(utterance.speechString)
        let rangeString = Range(characterRange, in: utterance.speechString)
        print(rangeString)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finish")
    }
}


