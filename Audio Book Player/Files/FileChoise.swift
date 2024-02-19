//
//  FileChoise.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 07.02.2024.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class adba:UITableViewController{
        
    @IBAction func test(_ sender: Any) {
        print("test file open")
        selectFoldersAndSaveToMemory()
    }
 
}


func selectFoldersAndSaveToMemory(){
    let supportedTypes = [UTType.mp3]

    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: false)
    documentPicker.allowsMultipleSelection = true
    documentPicker.delegate = DocumentPickerDelegate()
    
    UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
}

class DocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        var folderContentsDictionary = [String: [String]]()
        
        for url in urls {
            guard url.hasDirectoryPath else { continue }
            let folderPath = url.path
            print("folderPatch -> \(url.path)")
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: folderPath)
                folderContentsDictionary[folderPath] = contents
            } catch {
                print("Error reading contents of directory \(folderPath): \(error.localizedDescription)")
            }
        }
        
        // Save the dictionary to memory
        for file in folderContentsDictionary {
            print("file.key -> \(file.key) / file.value -> \(file.value)")
        }
        UserDefaults.standard.set(folderContentsDictionary, forKey: "filesList")
        UserDefaults.standard.synchronize()
    }
}

