import Foundation

struct Gratitude: Identifiable {
    var id = UUID()
    var createdAt: Any
    var message: String
    
    init(message: String) {
        self.message = message
        self.createdAt = Date()
    }
    
    init(entity: GratitudeEntity) {
        self.id = entity.id!
        self.createdAt = F.formatDate(format: "dd MMM yyyy", date: entity.createdAt!)
        self.message = entity.message!
    }
}
