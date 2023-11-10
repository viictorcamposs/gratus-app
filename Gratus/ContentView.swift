import SwiftUI

enum Tab {
    case feature
    case list
}

struct ContentView: View {
    
    @EnvironmentObject var manager: DataManager
    @State private var tab: Tab = .feature
    
    var body: some View {
        if manager.username.isEmpty {
            OnboardView()
        } else {
            TabView(selection: $tab) {
                CurrentDayGratitudeView()
                    .tabItem {
                        Image(systemName: "house.fill").padding(.top, 10)
                    }
                    .tag(Tab.feature)
                    
                GratitudeListView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle.fill")
                    }
                    .tag(Tab.list)
                    
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
