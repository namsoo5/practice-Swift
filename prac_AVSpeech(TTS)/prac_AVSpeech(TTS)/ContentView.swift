//
//  ContentView.swift
//  prac_AVSpeech(TTS)
//
//  Created by 남수김 on 2021/02/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let viewModel = ViewModel()
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("test", text: $text)
            Button(action: {
                viewModel.setText(text)
            }, label: {
                Text("재생")
            })
        }
    }
}
