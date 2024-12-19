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
        Date.now - TimeInterval(60 * 60 * 3 + 9320),
        Date.now - TimeInterval(60 * 60 * 2 + 5135),
        Date.now - TimeInterval(60 * 60),
        Date.now,
        Date.now + TimeInterval(60 * 60 * 3 + 1248),
        Date.now + TimeInterval(60 * 60 * 5 + 3358),
        Date.now + TimeInterval(60 * 60 * 7 + 7593),
        
        Date.now - TimeInterval(60 * 60 * 3 + 9320),
        Date.now - TimeInterval(60 * 60 * 2 + 5135),
        Date.now - TimeInterval(60 * 60),
        Date.now,
        Date.now + TimeInterval(60 * 60 * 3 + 1248) + TimeInterval(60 * 60 * 24),
        Date.now + TimeInterval(60 * 60 * 5 + 3358) + TimeInterval(60 * 60 * 24),
        Date.now + TimeInterval(60 * 60 * 7 + 7593) + TimeInterval(60 * 60 * 24),
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
        return Array(uniqueDatesByWeekday.values)
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
}
