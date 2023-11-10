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
    
    @Published var isShowingGratitudeEntry = false
    @Published var isSelectedWeekDayPreviousToCurrentDate = false
    @Published var isSelectedWeekDayLaterToCurrentDate = false
    @Published var selectedDayGratitudeEntry: String?
    @Published var selectedWeekDay: String {
        didSet {
            if self.selectedWeekDay.isEmpty { return }
            
            handleSelectedWeekDay()
        }
    }
    
    var manager: DataManager?
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
            
            selectedDayGratitudeEntry = getSelectedDayGratitudeEntry()
        } else if selectedWeekDay > formattedCurrentDate {
            isSelectedWeekDayLaterToCurrentDate = true
            isSelectedWeekDayPreviousToCurrentDate = false
        } else {
            isSelectedWeekDayLaterToCurrentDate = false
            isSelectedWeekDayPreviousToCurrentDate = false
            
            selectedDayGratitudeEntry = getSelectedDayGratitudeEntry()
        }
    }
    
    func getSelectedDayGratitudeEntry() -> String? {
        let filteredList = manager!.gratitudes.filter { gratitude in
            
            if let date = gratitude.createdAt {
                let formattedDate = F.formatDate(format: "dd MMM yyyy", date: date)
                
                return formattedDate == selectedWeekDay
            }
            
            return false
        }
        
        return filteredList.isEmpty ? nil : filteredList[0].message
    }
}

