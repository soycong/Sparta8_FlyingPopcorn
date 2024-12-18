//
//  DummyDataModel.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
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
            .locale(Locale(identifier: "ko_KR"))
        return formatter
    }()
    
    private static let weekdayOnlyFormatter = {
        let formatter = Date.FormatStyle()
            .weekday()
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
}
