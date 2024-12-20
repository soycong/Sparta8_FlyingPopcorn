//
//  TicketCinemaModel.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
//

import Foundation

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


