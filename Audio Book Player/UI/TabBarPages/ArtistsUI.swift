//
//  ArtistsUI.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct ArtistsUI: View {
    @State var Books: [Book]
    var body: some View {
        NavigationView {
            Text("Hello, World!")
        }
    }
}

#Preview {
    ArtistsUI(Books: loadBooksFromUserDefaults())
}
