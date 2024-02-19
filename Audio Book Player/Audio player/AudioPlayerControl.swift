//
//  AudioPlayerControl.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 11.02.2024.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation

class AudioUI: NSObject, ObservableObject {

    @State var CurentTime:Double = 0.0
    
    override init() {
        super.init()
    }
    
}
