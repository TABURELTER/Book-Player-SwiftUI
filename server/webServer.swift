
import Foundation
import GCDWebServers
 
func initWebServer() {
 
    let webServer = GCDWebServer()
 
    webServer.addDefaultHandlerForMethod("GET", requestClass: GCDWebServerRequest.self, processBlock: {request in
    return GCDWebServerDataResponse(HTML:"<html><body><p>Hello World</p></body></html>")
 
    })
 
    webServer.runWithPort(8080, bonjourName: "GCD Web Server")
 
    print("Visit \(webServer.serverURL) in your web browser")
}
