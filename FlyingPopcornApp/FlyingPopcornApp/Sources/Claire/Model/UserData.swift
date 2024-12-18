//
//  UserData.swift
//  Sai
//
//  Created by CHYUN on 12/18/24.
//

import Foundation

final class UserData {
    // 저장할 데이터: UUID, FamilyName, Name, Email, Password
//    var uuid: String
    var familyName: String
    var name: String
    var email: String
    var password: String
    
    init(familyName: String, name: String, email: String, password: String) {
//        self.uuid = NSUUID().uuidString
        self.familyName = familyName
        self.name = name
        self.email = email
        self.password = password
    }
}
