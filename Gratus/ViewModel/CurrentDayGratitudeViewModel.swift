import Foundation

struct WeekDay: Hashable, Identifiable {
    let id = UUID()
    let date: Date
    let isCurrentDay: Bool
    
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
}

class CurrentDayGratitudeViewModel {
    var weekDays: [WeekDay] = []
    
    init() {
        self.calculateRangeOfDays()
    }
    
    func calculateRangeOfDays() {
        let currentDate = Date()
        let calendar = Calendar.current

        var rangeOfDays = -2
        
        repeat {
            if let date = calendar.date(byAdding: .day, value: rangeOfDays, to: currentDate) {
                let day = WeekDay(date: date, 
                                  isCurrentDay: date == currentDate)
                
                weekDays.append(day)
            }
            
            rangeOfDays += 1
        } while weekDays.count < 5
    }
}
