//
//  test.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 31.01.2024.
//

import UIKit
import SwiftUI


class TestSaveLoad:UIViewController{
    
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var print: UITextField!
    @IBOutlet weak var load: UITextField!
    
    let defaults = UserDefaults.standard
    
    
    @IBAction func save(_ sender: Any) {
        Swift.print("save -> \(String(describing: input.text ?? ""))")
        defaults.set(input.text, forKey: "save")
        var t : Array<Int> = []
//                defaults.set(t,forKey: "asd")
        //        defaults.set(
        print.text = input.text
    }
    
    @IBAction func load(_ sender: Any) {
        Swift.print("load \(defaults.string(forKey: "save"))")
        load.text = defaults.string(forKey: "save") ?? "nil"
    }
    
    @IBAction func del(_ sender: Any) {
        //        Swift.print("remove")
        defaults.removeObject(forKey: "save")
    }
    let player = AudioEngine()
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    
}

class TryLoadSwiftUI : UIHostingController<TabBarUI> {
    //class TryLoadSwiftUI : UIHostingController<OpenPlayerUI> {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: TabBarUI())
        //            super.init(coder: aDecoder, rootView: OpenPlayerUI())
    }
}




