//
//  AudioPlayer.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 11.02.2024.
//

import SwiftUI
import AVFoundation
import AVKit

struct OpenPlayerUI: View {
    @State private var time: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var engine = AudioEngine()

    var body: some View {
        VStack {
            

            if let albumImage = loadAlbumImage(from: engine.player.url!) {
                Image(uiImage: albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 325, height: 325)
                    .cornerRadius(7.0)
                    .clipped()
            } else {
                Image("NoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 325, height: 325)
                    .cornerRadius(7.0)
                    .clipped()
            }
            
            Spacer().frame(height: 40)
            
            //TODO: ИЗМЕНИТЬ ПОЛУЧЕНИЕ ТЕКСТА В ОТДЕЛЬНУЮ ПЕРМЕННУЮ
            Text(engine.player.url!.lastPathComponent)
                .font(.system(size: 25, weight: .medium, design: .default))
            
            Spacer().frame(height: 50)
            
            Slider(
                value: Binding(
                    get: { time },
                    set: { newValue in
                        time = newValue
                        engine.player.currentTime = newValue
                    }
                ),
                in: 0...(engine.player.duration > 0 ? engine.player.duration : 1),
                onEditingChanged: { editing in
                    isEditing = editing
                    if !editing {
                        engine.player.currentTime = time
                    }
                }
            )
            .frame(width: 350)
            .frame(height: 20)
            
            HStack {
                Spacer().frame(width: 50)
                Text(formatTimeInterval(time)).font(.system(size: 15))
                Spacer()
                Text(formatTimeInterval(engine.player.duration)).font(.system(size: 15))
                Spacer().frame(width: 50)
            }
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
                    engine.player.currentTime -= 30
                }) {
                    Image(systemName: "gobackward.30")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
                
                Button(action: {
                    if engine.player.isPlaying {
                        engine.player.pause()
                    } else {
                        engine.player.play()
                    }
                }) {
                    Image(systemName: engine.player.isPlaying ? "pause.fill" : "play.fill")
                        .frame(width: 48, height: 48)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.3))
                }
                
                Button(action: {
                    time += 30
                    engine.player.currentTime += 30
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
                time = engine.player.currentTime
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
