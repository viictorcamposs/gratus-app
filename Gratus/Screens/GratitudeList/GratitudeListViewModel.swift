import Foundation

final class GratitudeListViewModel: ObservableObject {
    
    @Published var gratitudes: [Gratitude] = []
    
    func readGratitudesListData(manager: DataManager) {
        DispatchQueue.main.async {
            self.gratitudes = manager.gratitudes.map { gratitudeEntity in
                Gratitude(entity: gratitudeEntity)
            }
        }
    }
    
}
