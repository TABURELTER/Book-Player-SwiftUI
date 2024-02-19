//
//  FilesUI\.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct FilesUI: View {
    @State private var showFileImporter = false
    @State private var selectedFolders: [URL] = []
    
    var body: some View {
        @State var _nameFonts = namedFonts
        
        NavigationView {
            List {
                ForEach(_nameFonts) { item in
//                ForEach(_nameFonts) { item in
                    NavigationLink {
                        BlurViewUI()
                    } label: {
                        Label(item.name, systemImage: "folder").lineLimit(1)
                        Text("13ч 24м").frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                
            }.navigationTitle("Файлы")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarItems(trailing:
                                        Button(action: {
                    //TODO: добавить алерт с обьяснением и чек боксом
                    showFileImporter = true
                    
                }) {
                    Image(systemName: "plus")
                    
                }.fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.folder]) { result in
                    switch result {
                    case .success(let folder):
                        // Преобразуем URL папки в массив файлов
                        print(folder.lastPathComponent)
                        
                        if let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) {
                            // Выводим названия файлов в консоль
                            for fileURL in files {
                                print(fileURL.lastPathComponent)
                            }
                        } else {
                            print("Failed to get contents of directory")
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
        }
    }
}



private struct NamedFont: Identifiable {
    let name: String
    let font: Font
    let color: Color
    var id: String { name }
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

private var namedFonts: [NamedFont] = [
    NamedFont(name: randomString(length: 7), font: .largeTitle, color: .red),
    NamedFont(name: randomString(length: 7), font: .title, color: .green),
    NamedFont(name: randomString(length: 7), font: .headline, color: .blue),
    NamedFont(name: randomString(length: 7), font: .largeTitle, color: .red),
    NamedFont(name: randomString(length: 7), font: .title, color: .green),
    NamedFont(name: randomString(length: 7), font: .headline, color: .blue),
    NamedFont(name: randomString(length: 7), font: .largeTitle, color: .red),
    NamedFont(name: randomString(length: 7), font: .title, color: .green),
]

#Preview {
    FilesUI()
}
