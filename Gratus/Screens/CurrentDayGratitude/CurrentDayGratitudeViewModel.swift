import SwiftUI

struct WeekDay: Hashable, Identifiable {
    let id = UUID()
    var rawDate: Date
    var isCurrentDay: Bool
    
    var date: String {
        F.formatDate(format: "dd MMM yyyy", date: rawDate)
    }
    
    var dayString: String {
        F.formatDate(format: "EEE", date: rawDate)
    }
    
    var dayNumber: String {
        F.formatDate(format: "dd", date: rawDate)
    }
}

final class CurrentDayGratitudeViewModel: ObservableObject {
    
    @Published var isShowingGratitudeEntry: Bool = false
    @Published var isSelectedWeekDayPreviousToCurrentDate = false
    @Published var isSelectedWeekDayLaterToCurrentDate = false
    @Published var selectedWeekDay: String {
        didSet {
            if self.selectedWeekDay.isEmpty { return }
            
            handleSelectedWeekDay()
        }
    }
    
    var weekDays: [WeekDay] = []
    
    init() {
        self.selectedWeekDay = ""
        
        calculateRangeOfDays()
    }
    
    func calculateRangeOfDays() {
        let currentDate = Date()
        let calendar = Calendar.current

        var rangeOfDays = -2
        
        repeat {
            if let date = calendar.date(byAdding: .day, value: rangeOfDays, to: currentDate) {
                let day = WeekDay(rawDate: date,
                                  isCurrentDay: date == currentDate)
                
                weekDays.append(day)
            }
            
            rangeOfDays += 1
        } while weekDays.count < 5
    }
    
    func handleSelectedWeekDay() {
        let formattedCurrentDate = F.formatDate(format: "dd MMM yyyy", date: Date())
        
        if selectedWeekDay < formattedCurrentDate {
            isSelectedWeekDayLaterToCurrentDate = false
            isSelectedWeekDayPreviousToCurrentDate = true
        } else if selectedWeekDay > formattedCurrentDate {
            isSelectedWeekDayLaterToCurrentDate = true
            isSelectedWeekDayPreviousToCurrentDate = false
        } else {
            isSelectedWeekDayLaterToCurrentDate = false
            isSelectedWeekDayPreviousToCurrentDate = false
        }
    }
    
    func getSelectedDayGratitudeEntry(manager: DataManager) -> String? {
        let filteredList = manager.gratitudes.filter { gratitude in
            gratitude.createdAt as! String == selectedWeekDay
        }
        
        return filteredList.count == 0 ? nil : filteredList[0].message
    }
}

