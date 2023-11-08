import SwiftUI

struct ContentView: View {
    @StateObject var manager = GratusManager()
    
    var body: some View {
        if manager.username.isEmpty {
            OnboardView()
                .environmentObject(manager)
        } else {
            TabView() {
                CurrentDayGratitudeView()
                    .tabItem {
                        Image(systemName: "house.fill").padding(.top, 10)
                    }
                    
                GratitudeListView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle.fill")
                    }
                    
            }
            .accentColor(.white)
            .environmentObject(manager)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
