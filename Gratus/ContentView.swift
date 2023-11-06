import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var manager: GratusManager
    
    var body: some View {
        if manager.username != nil {
            TabView() {
                CurrentDayGratitudeView()
                    .environmentObject(manager)
                    .tabItem {
                        Image(systemName: "house.fill").padding(.top, 10)
                    }
                    
                ZStack {
                    BgGradientView()
                    Text("List of gratitude entries")
                        .foregroundStyle(.white)
                }
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle.fill")
                    }
                    
            }
            .accentColor(.white)
        } else {
            OnboardView()
                .environmentObject(manager)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GratusManager())
}
