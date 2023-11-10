import Foundation

final class GratitudeListViewModel: ObservableObject {
    
    @Published var gratitudes: [Gratitude] = []
    @Published var isShowingGratitudeEntry = false
    
    func readGratitudesListData(manager: DataManager) {
        DispatchQueue.main.async {
            self.gratitudes = manager.gratitudes.map { gratitudeEntity in
                Gratitude(entity: gratitudeEntity)
            }
        }
    }
    
}
