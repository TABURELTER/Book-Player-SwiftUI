//
//  TabBar.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct TabBarUI: View {
    @State var expandet = false
    @State private var Books: [Book] = []
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            TabView() {
                AlbumUI(Books: Books)
                //                    .badge(2) //TODO: ADD CHECK FOR IOS 15
                    .tabItem {
                        Label("Альбомы", systemImage: "list.clipboard.fill")
                    }
                ArtistsUI(Books: Books)
                    .tabItem {
                        Label("Исполнители", systemImage: "music.mic.circle.fill")
                    }
                FilesUI(Books: Books)
                //                    .badge("!") //TODO: ADD CHECK FOR IOS 15
                    .tabItem {
                        Label("Файлы", systemImage: "folder.fill")
                    }
                
//                OpenPlayerUI()
//                    .tabItem {
//                        Label("плеер", systemImage: "play.fill")
//                    }
                
            }.background(BlurViewUI())
            
            ClosePlayerUI(animation: animation, expand: $expandet)
        }).onAppear(){
            Books = loadBooksFromUserDefaults()
        }
    }
}

#Preview {
    TabBarUI()
}
