import SwiftUI

final class GratusManager: ObservableObject {
    @Published var username = String() // it'll be stored in UserDefaults
    @Published var gratitudeList: [GratitudeEntry] = []
    
    func addGratitude(gratitude: GratitudeEntry) {
        gratitudeList.append(gratitude)
    }
}
