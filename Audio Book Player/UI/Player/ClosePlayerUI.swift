//
//  ClosePlayerUI.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct ClosePlayerUI: View {
    var animation: Namespace.ID
    @Binding var expand : Bool
    
    var body: some View {
        
        VStack{
            HStack(spacing: 5){
                Image("testimg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55,height: 55)
                    .cornerRadius(12)
                Spacer().frame(width: 0.2)
                VStack(){
                    Text("TEST IMG")
                        .font(.title2)
                        .fontWeight(.bold)
                        .offset(x: -35,y: 3)
                    
                    //                    Text("1:27 / 3:17")
                    
                    ProgressView(value: 38.5,total: 100).frame(width: 150).offset(x:-9,y:-2)
                }.frame(width: 170)
                
                
                
                Spacer().frame(width: 0.0)
                
                Button(action: {}, label: {
                    Image(systemName:"backward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                })
                Spacer().frame(width: 0.6)
                Button(action: {}, label: {
                    //                        Image(systemName: engine.player.isPlaying ? "pause.fill" : "play.fill")
                    Image(systemName:"play.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                })
                Spacer().frame(width: 0.6)
                Button(action: {}, label: {
                    Image(systemName:"forward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                })
                
                Spacer().frame(width: 0.2)
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: expand ? .infinity : 60)
        .background(
            VStack(){
                BlurViewUI()
                    .frame(height: expand ? .infinity : 60)
                //                    .frame(height: 60)
                    .cornerRadius(expand ? 0 : 7)
                //                Divider()
            }
                .onTapGesture(perform: {
                    withAnimation(.spring()){expand.toggle()}
                })
        )
        .ignoresSafeArea()
        .offset(y: -49)
        
    }
    
    
}

//#Preview {
//    var animation: Namespace.ID
//    @State var expandet = false
//    ClosePlayerUI(animation: animation, expand: $expandet)
//}
