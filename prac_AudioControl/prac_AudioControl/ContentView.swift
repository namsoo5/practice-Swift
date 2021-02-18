//
//  ContentView.swift
//  prac_AudioControl
//
//  Created by 남수김 on 2021/02/15.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var viewModel: AudioViewModel
    @State var isRecord: Bool = false
    
    var body: some View {
        VStack {
            ForEach(viewModel.audios) { audio in
                HStack {
                    Text("\(audio.id)번 음악")
                    if let time = audio.duration {
                        Text("\(time)")
                    }
                    Button {
                        viewModel.playAudio(audio)
                        print("play")
                    } label: {
                        Text("재생")
                    }
                }
            }
            Button {
                setAudio()
            } label: {
                Text("초기 데이터")
            }
            Button {
                isRecord ? viewModel.stopRecord() : viewModel.record()
                isRecord = !isRecord
            } label: {
                if isRecord {
                    Text("녹음중지")
                } else {
                    Text("녹음하기")
                }
            }
        }
    }
    
    func setAudio() {
        if let url = Bundle.main.url(forResource: "Idiotape", withExtension: ".mp3") {
            viewModel.addAudio(url)
        }
    }
}

