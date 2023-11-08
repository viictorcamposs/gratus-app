import Foundation

struct GratitudeEntry: Hashable, Identifiable {
    let id = UUID()
    
    var createdAt: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: Date())
    }
    
    let text: String
}
