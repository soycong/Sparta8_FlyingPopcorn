//
//  UserData.swift
//  Sai
//
//  Created by CHYUN on 12/18/24.
//

import Foundation


// Mark: - Movie, Ticket 데이터 필요

final class UserData: Codable {
    var familyName: String
    var name: String
    var email: String
    var password: String
    
    init(familyName: String, name: String, email: String, password: String) {
        self.familyName = familyName
        self.name = name
        self.email = email
        self.password = password
        self.tickets = tickets
    }
}
