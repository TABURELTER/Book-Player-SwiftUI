//
//  FilesUI\.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//


import SwiftUI
import Foundation
import AVFoundation

struct FilesUI: View {
    @State private var showFileImporter = false
    @State private var showAlert = false
    @State private var selectedFolders: [URL] = []
    @State var Books: [Book]
    
    var body: some View {
        NavigationView {
            List {
                if Books.isEmpty {
                    NavigationLink(destination: BookPreviewUI(book: generateBook())) {
                        HStack {
                            Label("Имя книги", systemImage: "text.book.closed")
                            Spacer()
                            Text("общее время книги")
                        }
                    }
                }
                ForEach(Books){ item in
                    NavigationLink(destination: BookPreviewUI(book: item)) {
                        HStack {
                            Label(item.name, systemImage: "text.book.closed")
                                .lineLimit(1)
                            Spacer()
                            Text(item.time.formattedTimeWithoutSecondsAndWords)
                        }
                    }
                }
            }
            .navigationTitle("Файлы")
            .navigationBarItems(
                leading: Button(action: {
                    Books = []
                    saveBooksToUserDefaults(b: Books)
                }) {
                    Image(systemName: "archivebox.fill")
                },
                trailing: Button(action: {
                    //TODO: добавить алерт с обьяснением и чек боксом
                    showFileImporter = true
                    //                    showAlert = true
                }) {
                    Image(systemName: "plus")
                }.fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.folder]) { result in
                    switch result {
                    case .success(let folder):
                        print(folder.lastPathComponent)
                        if let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) {
                            for fileURL in files {
                                print(fileURL.lastPathComponent)
                                
                                if( Books.contains { $0.name == fileURL.lastPathComponent }){
                                    print("папка уже существует")
                                }else{
                                    let audioFiles = ScanFilder(folder: fileURL)
                                    var prew : URL = rootURL
                                    var time = Time(totalSeconds: 0)
                                    for audioFile in audioFiles {
                                        let asset = AVURLAsset(url: audioFile)
                                        let audioDuration = asset.duration.seconds
                                        time = Time(totalSeconds: time.rawTime+Int(audioDuration))
                                        
                                        //                                        for af in aufioFiles {
                                        //                                            print(af.lastPathComponent)
                                        if(audioFile.lastPathComponent.contains(".png") || audioFile.lastPathComponent.contains(".jpeg") || audioFile.lastPathComponent.contains(".jpg")){
                                            prew = audioFile
                                        }
                                    }
                                    
                                    let newBook = Book(name: fileURL.lastPathComponent,
                                                       author: "неизвестный",
                                                       //                                                   preview: prew,
                                                       time: time,
                                                       url: fileURL,
                                                       files: audioFiles
                                    )
                                    print("Время данной книги -> \(time.formattedTimeWithSeconds)")
                                    print("обложка -> \(newBook.preview)")
                                    Books.append(newBook)
                                }
                                print()
                            }
                            print("Завершили добавление книг в масив")
                            saveBooksToUserDefaults(b: Books)
                            
                        } else {
                            print("Failed to get contents of directory")
                        }
                    case .failure(let error):
                        print("словили ошибку -> \(error.localizedDescription)")
                    }
                }
            ) .onAppear {
                // Используйте UserDefaults для загрузки данных
            }
        }
    }
}






#Preview {
    FilesUI(Books:  generateBooks(i: 29))
}


let rootURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!






