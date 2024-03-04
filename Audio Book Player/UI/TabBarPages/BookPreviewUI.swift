//
//  BookPreviewUI.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 19.02.2024.
//

import SwiftUI
import Foundation
import SwiftAudioPlayer

struct BookPreviewUI: View {
    let book: Book
    
//    init(book: Book? = nil) {
//        if let book = book {
//            self.book = book
//        } else {
//            self.book = Book(name: "Очень крутая книга", files: generateRandomURLs(count: 10))
//        }
//    }
    
    var body: some View {
        //        NavigationView {
        List {
            VStack {
                if let uiImage = UIImage(named: book.preview) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 305, height: 305)
                        .cornerRadius(7.0)
                        .clipped()
                } else {
                    Image("NoImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 305, height: 305)
                        .cornerRadius(7.0)
                        .clipped()
                }
                
                
                Text(book.name)
                    .font(.title)
                
                //                    Text(book.author)
                //                        .font(.title2)
                
                Text("\(book.time.formattedTimeWithSeconds)")
                    .font(.title2)
            }
            .padding()
            
            ForEach(book.files, id: \.self) { item in
                if(item.lastPathComponent.contains(".mp3")){
                    FilesCells(read: true, name: item.lastPathComponent.replacingOccurrences(of: ".mp3", with: ""),time: book.time.formattedTimeWithoutSecondsAndWords, url:item.deletingPathExtension())
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .background(Color(UIColor.systemBackground))
                    
                    .onTapGesture {
                        print(item.absoluteString)
//                        SAPlayer.shared.DEBUG_MODE = true
                        AudioEngine.CurrentBook = book
                        let info = SALockScreenInfo(title: book.name, artist: book.author, albumTitle: "String?", artwork: UIImage(), releaseDate: 123456789)
                        SAPlayer.shared.startSavedAudio(withSavedUrl: item)
                        SAPlayer.shared.play()
                        SAPlayer.shared.mediaInfo = info
                        print("нажатие")
                    }
                }
            }
            Text("ничего").frame(width: 1, height: 40, alignment: .bottom)
        }
        
        .listStyle(PlainListStyle())
        .padding(.bottom, 8)
        .navigationTitle(book.author).navigationBarTitleDisplayMode(.inline)
    }
    
}




#Preview {
    BookPreviewUI(book: generateBook())
}
