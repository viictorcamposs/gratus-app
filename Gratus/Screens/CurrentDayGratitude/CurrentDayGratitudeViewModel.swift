import SwiftUI

func formatDate(format: String, date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

struct WeekDay: Hashable, Identifiable {
    let id = UUID()
    private var rawDate: Date
    var isCurrentDay: Bool
    
    var date: String {
        formatDate(format: "yyyy-MM-dd", date: rawDate)
    }
    
    var dayString: String {
        formatDate(format: "EEE", date: rawDate)
    }
    
    var dayNumber: String {
        formatDate(format: "dd", date: rawDate)
    }
    
    init(rawDate: Date, isCurrentDay: Bool) {
        self.rawDate = rawDate
        self.isCurrentDay = isCurrentDay
    }
}

final class CurrentDayGratitudeViewModel: ObservableObject {
    
    @Published var isShowingGratitudeEntry: Bool = false
    @Published var isSelectedWeekDayPreviousToCurrentDate = false
    @Published var isSelectedWeekDayLaterToCurrentDate = false
    @Published var selectedWeekDay: String {
        didSet {
            if self.selectedWeekDay.isEmpty { return }
            
            handleSelectedWeekDay(date: self.selectedWeekDay )
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
    
    func handleSelectedWeekDay(date selectedDate: String) {
        let formattedCurrentDate = formatDate(format: "yyyy-MM-dd", date: Date())
        
        if selectedDate < formattedCurrentDate {
            isSelectedWeekDayLaterToCurrentDate = false
            isSelectedWeekDayPreviousToCurrentDate = true
        } else if selectedDate > formattedCurrentDate {
            isSelectedWeekDayLaterToCurrentDate = true
            isSelectedWeekDayPreviousToCurrentDate = false
        } else {
            isSelectedWeekDayLaterToCurrentDate = false
            isSelectedWeekDayPreviousToCurrentDate = false
        }
    }
    
    func getSelectedDayGratitudeEntry(manager: GratusManager) -> String? {
        let filteredList = manager.gratitudeList.filter { gratitude in
            gratitude.createdAt == selectedWeekDay
        }
        
        return filteredList.count == 0 ? nil : filteredList[0].text
    }
}

