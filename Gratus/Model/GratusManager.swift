import Foundation

struct GratitudeEntry {
    let id = UUID()
    let createdAt: Date
    let gratitude: String
}

final class GratusManager: ObservableObject {
    @Published var username: String? // it'll be stored in UserDefaults
    @Published var gratitudeList: [GratitudeEntry] = []
    
    func addGratitude(gratitude: GratitudeEntry) {
        gratitudeList.append(gratitude)
        
        print(gratitudeList)
    }
}
