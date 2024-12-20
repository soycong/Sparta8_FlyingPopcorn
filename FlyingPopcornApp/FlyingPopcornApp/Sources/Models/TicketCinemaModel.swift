//
//  TicketCinemaModel.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
//

import Foundation

struct Tickets {
    static var bookedTickets: [Ticket] = []
}

struct Ticket {
    let movie: Movie
    let date: Date
    let format: String
    let quantity: Int
}

struct Cinema {
    static let name: String = "Salt and Butter Popcorn Cinema"
    static let availableFormat: [String] = ["2D", "3D", "IMAX"]
    static let schedule: [Date] = [
        // MARK: - Date data for today (D+0)
        Date.theDay, // 2024-12-20 09:30:00 KST
        Date.theDay + (Date.oneHour * 2),
        Date.theDay + (Date.oneHour * 4),
        Date.theDay + (Date.oneHour * 6),
        Date.theDay + (Date.oneHour * 8),
        Date.theDay + (Date.oneHour * 10),
        
        // MARK: - Date data for D+1
        Date.theDay + Date.oneDay, // 2024-12-21 09:30:00 KST
        Date.theDay + Date.oneDay + (Date.oneHour * 3),
        Date.theDay + Date.oneDay + (Date.oneHour * 5),
        Date.theDay + Date.oneDay + (Date.oneHour * 7),
        Date.theDay + Date.oneDay + (Date.oneHour * 9),
        Date.theDay + Date.oneDay + (Date.oneHour * 11),
        
        // MARK: - Date data for D+2
        Date.theDay + (Date.oneDay * 2), // 2024-12-22 09:30:00 KST
        Date.theDay + (Date.oneDay * 2) + (Date.oneHour * 2),
        Date.theDay + (Date.oneDay * 2) + (Date.oneHour * 4),
        Date.theDay + (Date.oneDay * 2) + (Date.oneHour * 6),
        Date.theDay + (Date.oneDay * 2) + (Date.oneHour * 8),
        Date.theDay + (Date.oneDay * 2) + (Date.oneHour * 10),
        
        // MARK: - Date data for D+2
        Date.theDay + (Date.oneDay * 3), // 2024-12-23 09:30:00 KST
        Date.theDay + (Date.oneDay * 3) + (Date.oneHour * 3),
        Date.theDay + (Date.oneDay * 3) + (Date.oneHour * 5),
        Date.theDay + (Date.oneDay * 3) + (Date.oneHour * 7),
        Date.theDay + (Date.oneDay * 3) + (Date.oneHour * 9),
        Date.theDay + (Date.oneDay * 3) + (Date.oneHour * 11),
        
        // MARK: - Date data for D+3
        Date.theDay + (Date.oneDay * 4), // 2024-12-24 09:30:00 KST
        Date.theDay + (Date.oneDay * 4) + (Date.oneHour * 2),
        Date.theDay + (Date.oneDay * 4) + (Date.oneHour * 4),
        Date.theDay + (Date.oneDay * 4) + (Date.oneHour * 6),
        Date.theDay + (Date.oneDay * 4) + (Date.oneHour * 8),
        Date.theDay + (Date.oneDay * 4) + (Date.oneHour * 10),
        
        // MARK: - Date data for D+4
        Date.theDay + (Date.oneDay * 5), // 2024-12-25 09:30:00 KST
        Date.theDay + (Date.oneDay * 5) + (Date.oneHour * 3),
        Date.theDay + (Date.oneDay * 5) + (Date.oneHour * 5),
        Date.theDay + (Date.oneDay * 5) + (Date.oneHour * 7),
        Date.theDay + (Date.oneDay * 5) + (Date.oneHour * 9),
        Date.theDay + (Date.oneDay * 5) + (Date.oneHour * 11),
        
        // MARK: - Date data for D+5
        Date.theDay + (Date.oneDay * 6), // 2024-12-26 09:30:00 KST
        Date.theDay + (Date.oneDay * 6) + (Date.oneHour * 2),
        Date.theDay + (Date.oneDay * 6) + (Date.oneHour * 4),
        Date.theDay + (Date.oneDay * 6) + (Date.oneHour * 6),
        Date.theDay + (Date.oneDay * 6) + (Date.oneHour * 8),
        Date.theDay + (Date.oneDay * 6) + (Date.oneHour * 10),
    ]
    
    static let scheduleInWeekDays: [Date] = {
        let calendar = Calendar.current
        var uniqueDatesByWeekday: [Int: Date] = [:]
        
        for date in schedule {
            let weekday = calendar.component(.weekday, from: date)
            if uniqueDatesByWeekday[weekday] == nil {
                uniqueDatesByWeekday[weekday] = date
            }
        }
        print(uniqueDatesByWeekday)
        return Array(uniqueDatesByWeekday.values).sorted(by: <)
    }()
    
}

extension Date {
    private static let monthOnlyFormatter = {
        let formatter = Date.FormatStyle()
            .month()
            .locale(Locale(identifier: "ko_KR"))
        return formatter
    }()
    
    private static let dayOnlyFormatter = {
        let formatter = Date.FormatStyle()
            .day()
            .locale(Locale(identifier: "en_US"))
        return formatter
    }()
    
    private static let weekdayOnlyFormatter = {
        let formatter = Date.FormatStyle()
            .weekday()
            .locale(Locale(identifier: "ko_KR"))
        return formatter
    }()
    
    private static let hourAndMinuteOnlyFormatter = {
        let formatter = Date.FormatStyle()
            .hour()
            .minute()
            .locale(Locale(identifier: "en_US"))
        return formatter
    }()
    
    private static let standardFormatter = {
        let formatter = Date.FormatStyle()
            .month()
            .day()
            .weekday()
            .hour()
            .minute()
            .locale(Locale(identifier: "ko_KR"))
        return formatter
    }()
    
    internal var monthOnly: String {
        return Date.monthOnlyFormatter.format(self)
    }
    
    internal var dayOnly: String {
        return Date.dayOnlyFormatter.format(self)
    }
    
    internal var weekdayOnly: String {
        return Date.weekdayOnlyFormatter.format(self)
    }
    
    internal var hourAndMinuteOnly: String {
        return Date.hourAndMinuteOnlyFormatter.format(self)
    }
    
    internal var standard: String {
        return Date.standardFormatter.format(self)
    }
    
    static let theDay = {
        return Date(timeIntervalSinceReferenceDate: 756347400)
    }()
    
    static let oneHour = {
        return TimeInterval(TimeInterval(60 * 60))
    }()
    
    static let oneDay = {
        return TimeInterval(TimeInterval(60 * 60 * 24))
    }()
}
