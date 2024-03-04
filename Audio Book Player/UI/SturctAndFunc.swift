//
//  sturctAndFiles.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 22.02.2024.
//

import SwiftUI

struct Book: Identifiable, Codable {
    let name: String
    let author: String
    let preview: String
    let time: Time
    let url: URL
    let files: [URL]
    var id: String { name }
    
    // Реализация Encodable и Decodable для пользовательских типов
    enum CodingKeys: String, CodingKey {
        case name, author, preview, time, url, files
    }
    
    init(name: String, author: String = "неизвестный", preview: String = "NoImage", time: Time = Time(hours: 0, minutes: 0, seconds: 0), url: URL = URL(string: "https://example.com")!, files: [URL] = []) {
        self.name = name
        self.author = author
        self.preview = preview
        self.time = time
        self.url = url
        self.files = files.sorted { $0.lastPathComponent < $1.lastPathComponent }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        author = try container.decode(String.self, forKey: .author)
        preview = try container.decode(String.self, forKey: .preview)
        time = try container.decode(Time.self, forKey: .time)
        url = try container.decode(URL.self, forKey: .url)
        files = try container.decode([URL].self, forKey: .files)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(author, forKey: .author)
        try container.encode(preview, forKey: .preview)
        try container.encode(time, forKey: .time)
        try container.encode(url, forKey: .url)
        try container.encode(files, forKey: .files)
    }
}

struct Time: Codable {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(totalSeconds: Int) {
        hours = totalSeconds / 3600
        minutes = (totalSeconds % 3600) / 60
        seconds = totalSeconds % 60
    }
    
    var rawTime: Int {
        return hours * 3600 + minutes * 60 + seconds
    }
    
    var formattedTimeWithSeconds: String {
        return String(format: "%02dч:%02dм:%02dс", hours, minutes, seconds)
    }
    
    var rawTimeFormatet: [Int] {
        return [hours,minutes,seconds]
    }
    
    
    
    var formattedTimeWithoutSeconds: String {
        return String(format: "%02dч:%02dм", hours, minutes)
    }
    
    var formattedTimeWithoutSecondsAndWords: String {
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    
}


func nullURL() -> URL{
//    return URL.init(string: "") ?? URL.init(.applicationDirectory)
    let r = URL.init(string: "testimg")!
    return r
}


func generateBooks(i:Int) -> [Book]{
    var r:[Book] = []
    
    for _ in 0...i{
        r.append(Book(name: "name -> \(randomString(length: 15))", author: "author -> \(randomString(length: 15))", preview: "imgtest", time: Time(totalSeconds: 123), url: nullURL(), files: generateRandomURLs(count: 23)))
    }
    
  return r
}

func generateBook() -> Book{
    return Book(name: "Книга - \(randomString(length: 7))", author: "Автор - \(randomString(length: 5))", preview: "igmtest", time: Time(totalSeconds: 8765), files: generateRandomURLs(count: 10))
}


func saveBooksToUserDefaults(b: [Book]) {
    do {
        let encodedData = try JSONEncoder().encode(b)
        UserDefaults.standard.set(encodedData, forKey: "books")
    } catch {
        print("Error encoding books: \(error)")
    }
}
func loadBooksFromUserDefaults() -> [Book]{
    if let encodedData = UserDefaults.standard.data(forKey: "books") {
        do {
            let decodedBooks = try JSONDecoder().decode([Book].self, from: encodedData)
           return decodedBooks
        } catch {
            print("Error decoding books: \(error)")
        }
    }
    return []
}

func ScanFilder(folder: URL) -> [URL]{
    if let aufioFiles = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) {
        for af in aufioFiles {
            print(af.lastPathComponent)
            if(af.lastPathComponent.contains(".png") || af.lastPathComponent.contains(".jpeg") || af.lastPathComponent.contains(".jpg")){
            }
        }
        print("Возвращаем аудио файлы")
        return aufioFiles
    }
    return []
}
func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
}
func generateRandomURLs(count: Int) -> [URL] {
    var urls = [URL]()
    for _ in 0..<count {
        let urlString = "https://example.com/\(UUID().uuidString)"
        if let url = URL(string: urlString) {
            urls.append(url)
        }
    }
    return urls
}



let logo = """
 ________  ______  _______  __    __ _______  ________ __       ________ ________ _______
|        \\/      \\|       \\|  \\  |  \\       \\|        \\  \\     |        \\        \\       \\
 \\▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓\\ ▓▓▓▓▓▓▓\\ ▓▓  | ▓▓ ▓▓▓▓▓▓▓\\ ▓▓▓▓▓▓▓▓ ▓▓      \\▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓\\
   | ▓▓  | ▓▓__| ▓▓ ▓▓__/ ▓▓ ▓▓  | ▓▓ ▓▓__| ▓▓ ▓▓__   | ▓▓        | ▓▓  | ▓▓__   | ▓▓__| ▓▓
   | ▓▓  | ▓▓    ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  \\  | ▓▓        | ▓▓  | ▓▓  \\  | ▓▓    ▓▓
   | ▓▓  | ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓\\ ▓▓  | ▓▓ ▓▓▓▓▓▓▓\\ ▓▓▓▓▓  | ▓▓        | ▓▓  | ▓▓▓▓▓  | ▓▓▓▓▓▓▓\\
   | ▓▓  | ▓▓  | ▓▓ ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓  | ▓▓ ▓▓_____| ▓▓_____   | ▓▓  | ▓▓_____| ▓▓  | ▓▓
   | ▓▓  | ▓▓  | ▓▓ ▓▓    ▓▓\\▓▓    ▓▓ ▓▓  | ▓▓ ▓▓     \\ ▓▓     \\  | ▓▓  | ▓▓     \\ ▓▓  | ▓▓
    \\▓▓   \\▓▓   \\▓▓\\▓▓▓▓▓▓▓  \\▓▓▓▓▓▓ \\▓▓   \\▓▓\\▓▓▓▓▓▓▓▓\\▓▓▓▓▓▓▓▓   \\▓▓   \\▓▓▓▓▓▓▓▓\\▓▓   \\▓▓
                                                                                           
"""



