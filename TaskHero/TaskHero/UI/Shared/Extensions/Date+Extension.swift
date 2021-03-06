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
        let currentYear = dateFormat.string(from: now as Date)
        years.append(currentYear)
        let oneYear = TimeInterval(60 * 60 * 24 * 365)
        for _ in 1...3 {
            now = now + oneYear
            let dateInFormat = dateFormat.string(from: now as Date)
            years.append(dateInFormat)
        }
        print(years)
        return years
    }
    
    func getCalendarDates() -> Calendar {
        return Calendar.current
       
    }
}



extension UserDefaults {
    class func loginDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hasLoggedIn")
        defaults.synchronize()
    }
}



