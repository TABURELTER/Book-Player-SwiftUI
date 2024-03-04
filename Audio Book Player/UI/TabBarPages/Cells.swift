//
//  Cells.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 22.02.2024.
//

import SwiftUI


struct AlbumCells: View {
    var Book:Book
    @State private var startAnimation: Bool = false
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Image("ImgNoBG")
//                Image(Book.preview)
                    .resizable()
                    .background(Color .orange)
                    .scaledToFit()
                    .frame(width: 175, height: 175)
                    .cornerRadius(12)
                    .padding(10)
                
            }
            Group {
                Text("\(Book.name)")
                    .fixedSize()
                    .frame(width: 175, alignment: startAnimation ? .trailing : .leading)
                    .clipped()
            }
            HStack {
                Group {
                    Text("\(Book.author)")
                        .fixedSize()
                        .frame(width: 110, alignment: startAnimation ? .trailing : .leading)
                        .clipped()
                }
                
                Text(Book.time.formattedTimeWithoutSecondsAndWords)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .fixedSize()
        .padding()
        .onAppear {
            withAnimation(Animation.linear(duration: 10).delay(3).repeatForever()) {
                self.startAnimation.toggle()
            }
        }
        .background(BlurViewUI().frame(width: 200, height: 250))
    }
}

#Preview {
        AlbumCells(Book: Book(name: "Да и название длинное",
                         author: "Автор по длинее",
                         preview: "NoImage",
                         time: Time(hours: 293, minutes: 23, seconds: 32)))
//    FilesCells(read: true,name: "Доаольно длинное название кнги ", time: "99:00", url: nullURL())
}


struct FilesCells: View {
    @State var read:Bool
    @State var name:String
    @State var time:String
    @State var url:URL
    
    @State private var startAnimation: Bool = false
    
    var body: some View {
        
        HStack(content: {
            Image(systemName: read ? "checkmark.circle.fill":"xmark.circle.fill") .foregroundColor(Color(read ? .green:.red))
//            Divider()
            
            Group {
                Text("\(name)")
                    .fixedSize()
                    .clipped()
            }
            Spacer(minLength: 0)
//            Divider()
            
            Text(time)
            
            
            
        })
       
            
       
        .onAppear {
            withAnimation(Animation.linear(duration: 10).delay(3).repeatForever()) {
                self.startAnimation.toggle()
            }
        }
        
    }
}
