//
//  AlbumUI.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct AlbumUI: View {
    @State var Books: [Book]
    @State var GridItems: [GridItem] = [
        .init(),
        .init(),
       ]
    
    
    var body: some View {
        NavigationView{
            
            ScrollView(.vertical,showsIndicators: false) {
                LazyVGrid(columns: GridItems,spacing: 15) {
                    ForEach(Books) { b in
//                        Button, action: <#T##() -> Void#>)
                        
                        AlbumCells(Book: b).onTapGesture {
                            print("нажатие на альбом")
                            BookPreviewUI(book: b)
                        }
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke()
//                                .frame(width: 100, height: 100)
//                                .foregroundColor(.accentColor)
//                            Text("\(item)")
//                            Spacer()
//                        }
                    }
                }.padding(10)
            }
            
            .navigationTitle("Альбомы")
            .toolbar(){
                ToolbarItem{
                    Text("ToolbarItem")
                }
            }
        }
    }
}

#Preview {
    AlbumUI(Books: loadBooksFromUserDefaults())
}
