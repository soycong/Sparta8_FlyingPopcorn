//
//  UserData.swift
//  Sai
//
//  Created by CHYUN on 12/18/24.
//

import Foundation

final class UserData {
    // 싱글톤으로 사용할 유저 데이터
    static let loginedUser = UserData()
    
    private(set) var familyName: String?
    private(set) var name: String?
    private(set) var email: String?
    private(set) var password: String?
    private(set) var tickets: [Ticket] = []
    
    // 외부 초기화 방지
    private init() {}
    
    func updateUserInfo(familyName: String, name: String, email: String, password: String, tickets: [Ticket]) {
        self.familyName = familyName
        self.name = name
        self.email = email
        self.password = password
        self.tickets = tickets
    }
    
    // 데이터 초기화할 경우 (로그아웃...)
    func clearUserData() {
        familyName = nil
        name = nil
        email = nil
        password = nil
        tickets = []
    }
}
