//
//  Date+Extension.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/20/24.
//

import Foundation

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
