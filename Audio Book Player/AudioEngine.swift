//
//  AudioEngine.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 11.02.2024.
//

import SwiftAudioPlayer

class AudioEngine {
    
    static public var CurrentBook:Book = generateBook()
    
    static public var isPlaying:Bool = false
    
    
    func play(url:URL){
        SAPlayer.shared.startSavedAudio(withSavedUrl: url)
        AudioEngine.isPlaying = true
    }
    
    func PlayStop(){
        SAPlayer.shared.togglePlayAndPause()
        AudioEngine.isPlaying.toggle()
    }
    
    
    func ChangeRate(rate:Float){
        SAPlayer.shared.rate = rate
    }
}



