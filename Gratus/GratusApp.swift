import SwiftUI

@main
struct GratusApp: App {
    @StateObject var manager = GratusManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
