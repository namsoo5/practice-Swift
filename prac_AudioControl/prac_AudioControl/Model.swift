//
//  Model.swift
//  prac_AudioControl
//
//  Created by 남수김 on 2021/02/15.
//

import Foundation

struct AudioModel {
    var audios: [Audio] = []
    var uniqueId = 0
    
    struct Audio: Identifiable {
        var audio: Data
        var id: Int
        var duration: String?
        
        fileprivate init(audio: Data, id: Int) {
            self.audio = audio
            self.id = id
        }
    }
    
    mutating func addAudio(_ audio: Data) {
        uniqueId += 1
        audios.append(Audio(audio: audio, id: uniqueId))
    }
}
