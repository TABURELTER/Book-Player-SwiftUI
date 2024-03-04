//
//  ClosePlayerUI.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI
import SwiftAudioPlayer

struct ClosePlayerUI: View {
    var animation: Namespace.ID
    @Binding var expand : Bool
    var height = UIScreen.main.bounds.height / 3
    var SafeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                
                Capsule()
                    .fill(Color.red)
                    .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                    .opacity(expand ? 1 : 0)
                    .padding(.top, expand ?  SafeArea?.top : 0 )
                    .padding(.vertical, expand ?  20 : 0 )
                
                
                if expand{
                    Text(AudioEngine.CurrentBook.author)
                        .padding(.vertical,10)
                        .foregroundColor(.gray)
                }else{
                    Spacer(minLength:0)
                }
                

                HStack(spacing: 5){
                    
                    
                    let img = img(i:"testimg")
                    img.frame(width: expand ? height : 55,height: expand ? height : 55)
                    
                    
                    if !expand{
                        Spacer().frame(width: 0.2)
                        VStack(){
                            Text("TEST IMG")
                                .font(.title2)
                                .fontWeight(.bold)
                                .offset(x: -35,y: 3)
                            
                            ProgressView(value: (SAPlayer.shared.elapsedTime ?? 1), total: SAPlayer.shared.duration ?? 1).frame(width: 150).offset(x:-9,y:-2)
                            
                        }.frame(width: 170)
                        Spacer().frame(width: 0.0)
                        
                        
                        Button(action: {}, label: {
                            Image(systemName:"backward.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        })
                        Spacer().frame(width: 0.6)
                        Button(action: {SAPlayer.shared.togglePlayAndPause()}, label: {
//                            Image(systemName: playingStatusId == SAPlayingStatus.playing ? "pause.fill" : "play.fill")
                            Image(systemName: true ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        })
                        Spacer().frame(width: 0.6)
                        Button(action: {}, label: {
                            Image(systemName:"forward.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        })
                    }
                    
                    Spacer().frame(width: 0.2)
                }
                .padding(.horizontal)
                
                VStack(){
                    Text(AudioEngine.CurrentBook.name)
                        .font(.title2)
                        .padding(.top,10)
                    
                    
                    Spacer().frame(height: 40)
                    
                    
                    //крутой элемент интерфейса но по моему не совсем подходящий
//                    let cool = CoolCapsul(text: "aboba")
//                    cool
                    
                    
                    let musicSlider = MusicSlider()
                    musicSlider
                    
                    
                    let mediaButton = Controll()
                    mediaButton
                    
                    
                    let stepperView = StepperView()
                    //                    stepperView()
                    
                    
                    Spacer(minLength: 0)
                    
                }
                .frame(width: expand ? nil : 0, height: expand ? nil : 0)
                .opacity(expand ? 1:0)
            }
            .frame(maxWidth: .infinity, maxHeight: expand ? .infinity : 60)
            .background(
                VStack(){
                    BlurViewUI()
                        .frame(height: expand ? height * 3 : 60)
                }
                    .onTapGesture(perform: {
                        withAnimation(.spring()){expand.toggle()}
                    })
            )
            .offset(y: expand ? 0 : -49)
            .ignoresSafeArea()
            //            vs.opacity(1)
        }
        
    }
}


struct img:View {
    init(i:String){
        self.i = i
    }
    var i:String
    
    var body: some View {
        Image(i)
            .resizable()
            .aspectRatio(contentMode: .fill)
        
            .cornerRadius(12)
    }
}


struct CoolCapsul:View {
    init(text: String) {
        self.text = text
    }
    @State var text:String
    
    var body: some View {
        HStack{
            Capsule()
                .fill(
                    LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7),Color.primary.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(height: 4)
            Text(text).lineLimit(1)
            Capsule()
                .fill(
                    LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.1),Color.primary.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(height: 4)
        }.padding()
    }
}


struct MusicSlider: View {
    @State private var currentProgress: Float = 0.0

    var body: some View {
        MusicProgressSlider(value: $currentProgress,
                            inRange: 0...Float(SAPlayer.shared.duration ?? 0.1),
                            activeFillColor: .green,
                            fillColor: .accentColor,
                            emptyColor: .black,
                            height: 40) { editingChanged in
                                if !editingChanged {
                                    // Пользователь отпустил слайдер, применяем новое значение
                                    let newTime = Double(currentProgress) * (SAPlayer.shared.duration ?? 1)
                                    SAPlayer.shared.seekTo(seconds: newTime)
                                }
                            }
            .frame(width: 350)
            .onAppear {
                // Обновление текущего прогресса при запуске
                if let currentTime = SAPlayer.shared.elapsedTime {
                    currentProgress = Float(currentTime / (SAPlayer.shared.duration ?? 1))
                }
            }
            .onReceive(SAPlayer.shared.elapsedTime.publisher) { currentTime in
                // Обновляем прогресс при изменении времени воспроизведения
                currentProgress = Float(currentTime / (SAPlayer.shared.duration ?? 1))
            }
    }
}






struct Controll: View {
    var body: some View {
        HStack(spacing: 15) {
            
            Button(action: {
                
                
            }) {
                Image(systemName: "backward.fill")
                    .frame(width: 48, height: 48)
                    .imageScale(.large)
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
            }
            
            Button(action: {
//                SAPlayer.
            }) {
                Image(systemName: "gobackward.30")
                    .frame(width: 48, height: 48)
                    .imageScale(.large)
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
            }
            
            Button(action: {
                SAPlayer.shared.togglePlayAndPause()
            }) {
                Image(systemName: SAPlayer.shared.playerNode?.isPlaying ?? false ? "play.fill" : "pause.fill")
                    .frame(width: 48, height: 48)
                    .imageScale(.large)
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "goforward.30")
                    .frame(width: 48, height: 48)
                    .imageScale(.large)
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "forward.fill")
                    .frame(width: 48, height: 48)
                    .imageScale(.large)
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
            }
        }
    }
}


struct StepperView: View {
    @State var value = 0
    let step = 5
    let range = 1...50
    
    var body: some View {
        Stepper(
            value: $value,
            in: range,
            step: step
        )
        {
            //            Text("Current: \(value) in \(range.description) " +"stepping by \(step)")
        }
        //        .padding(10)
    }
}






struct ClosePlayerUI_Previews: PreviewProvider {
    static var previews: some View {
        ClosePlayerUI(animation: Namespace().wrappedValue, expand: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
