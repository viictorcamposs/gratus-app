import Foundation

struct GratitudeEntry: Hashable, Identifiable {
    let id = UUID()
    
    var createdAt: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    let gratitude: String
    private let date = Date()
}
