//
//  ConsoleFileManager.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 29.01.2024.
//

import Foundation

class ConsoleFileManager {
    var currentDirectory: URL

    init() {
        // Установим начальную директорию, например, Documents директорию в вашем приложении
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            currentDirectory = documentsDirectory
        } else {
            fatalError("Unable to determine the Documents directory.")
        }
    }

    func listContents() {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: currentDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            print("Contents of \(currentDirectory.path):")
            for url in contents {
                print("  \(url.lastPathComponent)")
            }
        } catch {
            print("Error listing contents of directory: \(error.localizedDescription)")
        }
    }

    func changeDirectory(to subdirectory: String) {
        let newDirectory = currentDirectory.appendingPathComponent(subdirectory)

        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: newDirectory.path, isDirectory: &isDirectory) && isDirectory.boolValue {
            currentDirectory = newDirectory
            print("Changed directory to \(currentDirectory.path)")
        } else {
            print("Error: \(subdirectory) is not a directory or does not exist.")
        }
    }
}


