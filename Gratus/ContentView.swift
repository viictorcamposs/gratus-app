import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: DataManager
    
    var body: some View {
        if manager.username.isEmpty {
            OnboardView()
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
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .environmentObject(DataManager())
}
