//
//  AudioPlayer.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 11.02.2024.
//

import SwiftUI
import AVFoundation
import SwiftAudioPlayer
import AVKit

struct OpenPlayerUI: View {
    
    @State private var time: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var engine = AudioEngine()

    @State private var playerDuration: TimeInterval = 100
    private let maxDuration = TimeInterval(240)
    
    @State private var volume: Double = 0.3
    private var maxVolume: Double = 1
    
    @State private var sliderValue: Double = 10
    private var maxSliderValue: Double = 100
    
    @State private var color: Color = .white
    
    var body: some View {
        VStack {
//            if let albumImage = loadAlbumImage(from: engine.player.url!) {
//                Image(uiImage: albumImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 325, height: 325)
//                    .cornerRadius(7.0)
//                    .clipped()
//            } else {
                Image("NoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 325, height: 325)
                    .cornerRadius(7.0)
                    .clipped()
//            }
            
            Spacer().frame(height: 40)
            
//            TODO: ИЗМЕНИТЬ ПОЛУЧЕНИЕ ТЕКСТА В ОТДЕЛЬНУЮ ПЕРМЕННУЮ
            
//            Text("engine.player.url!.lastPathComponent")
            
//            Text(SAPlayer.shared.)
                .font(.system(size: 25, weight: .medium, design: .default))
            
            Spacer().frame(height: 50)
            
            
            
            MusicProgressSlider(value: Binding(
                get: {SAPlayer.shared.elapsedTime ?? 0},
                set:{newV in
//                    time = newV
                    SAPlayer.shared.elapsedTime
                    }),
                                inRange: 0...(SAPlayer.shared.duration ?? 1),
                                activeFillColor: .green,
                                fillColor: .accentColor,
                                emptyColor: .black,
                                height: 32) { started in
                
            }.frame(width: 350, alignment: .center)
            
            
//            HStack {
//                Spacer().frame(width: 50)
//                Text(formatTimeInterval(time)).font(.system(size: 15))
//                Spacer()
//                Text(formatTimeInterval(engine.player.duration)).font(.system(size: 15))
//                Spacer().frame(width: 50)
//            }
            Spacer().frame(height: 35)
            
            HStack(spacing: 15) {
                Button(action: {
                    // Your action
                }) {
                    Image(systemName: "backward.fill")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
                
                Button(action: {
                    time -= 30
//                    engine.player.currentTime -= 30
                }) {
                    Image(systemName: "gobackward.30")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
                
                Button(action: {
                    SAPlayer.shared.togglePlayAndPause()
                }) {
                    Image(systemName:"play.fill")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
                
                Button(action: {
                    time += 30
//                    engine.player.currentTime += 30
                }) {
                    Image(systemName: "goforward.30")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
                
                Button(action: {
                    // Your action
                }) {
                    Image(systemName: "forward.fill")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
            }
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            if !isEditing {
//                time = engine.player.currentTime
            }
        }
    }
    
    func loadAlbumImage(from url: URL) -> UIImage? {
        guard let asset = AVAsset(url: url) as? AVURLAsset else { return nil }
        let playerItem = AVPlayerItem(asset: asset)
        let metadataList = playerItem.asset.metadata
        
        for metadata in metadataList {
            guard let key = metadata.commonKey,
                  let keyAsString = key.rawValue as? String,
                  keyAsString == "artwork",
                  let imageData = metadata.value as? Data,
                  let image = UIImage(data: imageData) else {
                continue
            }
            return image
        }
        return nil
    }
    
    func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: interval)!
    }
}

#Preview {
    OpenPlayerUI()
}
