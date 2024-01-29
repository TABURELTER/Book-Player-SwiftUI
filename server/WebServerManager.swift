//
//  WebServerManager.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 28.01.2024.
//


import GCDWebServer


class WebServerManager {
    var webServer: GCDWebServer?

    func startServer() {
        guard webServer == nil || !webServer!.isRunning else {
            print("Server is already running")
            return
        }

        webServer = GCDWebServer()

        // Отдаем статические файлы (HTML, CSS, JS) из файловой системы
        let bundleURL = Bundle.main.bundleURL
        let sitePath = bundleURL.appendingPathComponent("index.html")

        do {
            let directoryPath = sitePath.deletingLastPathComponent().path
            webServer?.addGETHandler(forBasePath: "/", directoryPath: directoryPath, indexFilename: sitePath.lastPathComponent, cacheAge: 3600, allowRangeRequests: true)
        } catch let error {
            print("Error setting up server: \(error)")
            return
        }

        do {
            try webServer?.start(options: [GCDWebServerOption_Port: 8080, GCDWebServerOption_BindToLocalhost: true])
            print("Server running on port 8080")
        } catch let error {
            print("Error starting server: \(error)")
        }
    }

    func stopServer() {
        webServer?.stop()
        webServer = nil
        print("Server stopped")
    }
}



