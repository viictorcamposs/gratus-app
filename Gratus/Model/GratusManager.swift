import SwiftUI

final class GratusManager: ObservableObject {
    
    @Published var username = String()
    @Published var gratitudeList: [GratitudeEntry] = []
    
    let defaults = UserDefaults.standard
    
    init() {
        if let username = defaults.string(forKey: K.defaults.username) {
            self.username = username
        }
    }
    
    func saveUsername(_ username: String) {
        defaults.set(username, forKey: K.defaults.username)
        self.username = username
    }
    
    func addGratitude(gratitude: GratitudeEntry) {
        gratitudeList.append(gratitude)
    }
}
