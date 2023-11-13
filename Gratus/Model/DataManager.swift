import CoreData
import Foundation

final class DataManager: ObservableObject {
    
    @Published var username = String()
    @Published var gratitudes: [GratitudeEntity] = []
    
    let defaults = UserDefaults.standard
    
    let container = NSPersistentContainer(name: "GratitudesContainer")
    
    init() {
        if let username = defaults.string(forKey: K.defaults.username) {
            self.username = username
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Not able to load core data.: \(error)")
            }
        }
        
        fetchGratitudes()
    }
    
    func saveUsername(_ username: String) {
        defaults.set(username, forKey: K.defaults.username)
        self.username = username
    }
    
    func fetchGratitudes() {
        let request = NSFetchRequest<GratitudeEntity>(entityName: "GratitudeEntity")
        
        do {
            gratitudes = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching GratitudeEntity.: \(error)")
        }
    }
    
    func addGratitude(gratitude: Gratitude) {
        let newGratitude = GratitudeEntity(context: container.viewContext)
        
        newGratitude.id = gratitude.id
        newGratitude.message = gratitude.message
        newGratitude.createdAt = gratitude.createdAt as? Date
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            
            fetchGratitudes()
        } catch {
            print("Unable to save data in CoreData.: \(error)")
        }
    }
}
