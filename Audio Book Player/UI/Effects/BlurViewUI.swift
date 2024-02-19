//
//  BlurViewUI.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 17.02.2024.
//

import SwiftUI

struct BlurViewUI: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
//        let effect =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial ))
        let effect =  UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        return effect
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    }
}
