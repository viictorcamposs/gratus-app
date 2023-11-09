import SwiftUI

@main
struct GratusApp: App {
    @StateObject private var manager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(manager)
        }
    }
}
