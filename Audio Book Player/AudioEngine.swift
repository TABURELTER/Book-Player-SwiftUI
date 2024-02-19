//
//  AudioEngine.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 11.02.2024.
//

import AVFoundation

class AudioEngine {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var player: AVAudioPlayer!
    
    init() {
        // Создаем экземпляр AVAudioEngine
        audioEngine = AVAudioEngine()
        //        player = AVPlayer()
        
        
        // Создаем экземпляр AVAudioPlayerNode
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        // Получаем путь к аудиофайлу
        //        guard let audioFilePath = Bundle.main.path(forResource: "The-Weeknd-Biling-Lights", ofType: "mp3") else {
        //            fatalError("Аудиофайл не найден")
        //        }
        
        var url = URL(fileURLWithPath: Bundle.main.path(forResource: "The Hatters - Я делаю шаг.mp3", ofType: nil)!)
        //        var url = URL(fileURLWithPath: Bundle.main.path(forResource: "The-Weeknd-Biling-Lights.mp3", ofType: nil)!)
        var error: Error?
        do {
            player = try AVAudioPlayer(contentsOf: url)
        }
        catch let error {
        }
        if player == nil {
            print("Error: \(String(describing: error))")
        }
        
        
        // Создаем экземпляр AVAudioFile на основе пути к аудиофайлу
        //        do {
        //            audioFile = try AVAudioFile(forReading: URL(fileURLWithPath: audioFilePath))
        //        } catch {
        //            fatalError("Ошибка при создании AVAudioFile: \(error)")
        //        }
        
        // Подключаем AVAudioPlayerNode к mainMixerNode
        //        let mixer = audioEngine.mainMixerNode
        //        audioEngine.connect(audioPlayerNode, to: mixer, format: audioFile.processingFormat)
    }
    
    func play() {
        // Запускаем AVAudioEngine
        do {
            try audioEngine.start()
        } catch {
            fatalError("Ошибка при запуске AVAudioEngine: \(error)")
        }
        
        // Запускаем воспроизведение аудиофайла
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        audioPlayerNode.play()
    }
    
    func pause(){
        audioEngine.pause()
    }
    
    func updateTime() -> Double {
        return 0.0
    }
    
    func GetTime() -> Double{
        return player.currentTime
    }
}


