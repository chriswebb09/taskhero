import Foundation

extension Date {
    func dateStringFormatted() -> String {
        let today = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-yyyy"
        let dateInFormat = dateFormat.string(from: today as Date)
        return dateInFormat
    }
    
    func getYears() -> [String] {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy"
        var years = [String]()
        var now = Date()
        var currentYear = dateFormat.string(from: now as Date)
        years.append(currentYear)
        let oneYear = TimeInterval(60 * 60 * 24 * 365)
        for i in 1...3 {
            now = now + oneYear
            let dateInFormat = dateFormat.string(from: now as Date)
            years.append(dateInFormat)
        }
        print(years)
        return years
    }
    
    func getCalendarDates() {
        let userCalendar = Calendar.current
        
    }
    
//    func getMonths() -> [String] {
//        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = "yyyy"
//
//    }

}


