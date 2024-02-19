//
//  TabBar.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct TabBarUI: View {
    @State var Current = 3
    @State var expandet = false
    
    @Namespace var animation
    
    var body: some View {
        
        
        
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            TabView(selection: $Current) {
                AlbumUI()
                //                    .frame(width: 1000,height: 1000).background(Color.red)
                //                    .badge(2) //TODO: ADD CHECK FOR IOS 15
                    .tabItem {
                        Label("Альбомы", systemImage: "list.clipboard.fill")
                    }
                ArtistsUI()
                    .tabItem {
                        Label("Исполнители", systemImage: "music.mic.circle.fill")
                    }
                FilesUI()
                //                    .badge("!") //TODO: ADD CHECK FOR IOS 15
                    .tabItem {
                        Label("Файлы", systemImage: "folder.fill")
                    }
                
            }
            
            ClosePlayerUI(animation: animation, expand: $expandet)
            
            
        })
    }
}

#Preview {
    TabBarUI()
}
