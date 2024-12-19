//
//  UserDefaultsHelper.swift
//  Sai
//
//  Created by Claire on 12/18/24.
//

import Foundation

final class UserDefaultsHelper {
    // 싱글톤으로 사용할 헬퍼
    static let userDefaultsHelper = UserDefaultsHelper()
    
    private let userKey = "userData"
    private let familyNameKey = "familyName"
    private let nameKey = "name"
    private let emailKey = "email"
    private let passwordKey = "password"
    private let ticketsKey = "tickets"
    private let defaults = UserDefaults.standard
    
    // 외부 초기화 방지
    private init() {}
    
    // 유저 데이터 저장
    func saveUserData(user: UserData) {
        var userDictionary = getUserDictionary()
        
        guard let email = user.email else { return }
        
        let userData: [String: Any] = [
            familyNameKey: user.familyName ?? "",
            nameKey: user.name ?? "",
            emailKey: email,
            passwordKey: user.password ?? "",
            ticketsKey: user.tickets as Any
        ]
        
        userDictionary[email] = userData
        defaults.set(userDictionary, forKey: userKey)
    }
    
    // 일치하는 유저 데이터 체크
    func checkUserData(email: String, password: String) -> (response: Bool, password: String) {
        let userDictionary = getUserDictionary()
        
        guard let userData = userDictionary[email],
              let storedPassword = userData[passwordKey] as? String else {
            return (false, "")
        }
        return (storedPassword == password, storedPassword)
    }
    
    private func getUserDictionary() -> [String: [String: Any]] {
        if let data = defaults.object(forKey: userKey) as? [String: [String: Any]] {
            return data
        }
        return [:]
    }
    
    private let currentUserKey = "currentUser"
    
    // 현재 로그인된 사용자 이메일 저장
    func saveCurrentUser(email: String) {
        defaults.set(email, forKey: currentUserKey)
    }
    
    // 현재 로그인된 사용자 이메일 가져오기
    func getCurrentUser() -> String? {
        return defaults.string(forKey: currentUserKey)
    }
    
    // 로그아웃 시 현재 사용자 정보 삭제
    func clearCurrentUser() {
        defaults.removeObject(forKey: currentUserKey)
    }
    
    // 저장된 사용자 정보로 UserData 업데이트
    func loadUserData(email: String) {
        let userDictionary = getUserDictionary()
        guard let userData = userDictionary[email] else { return }
        
        UserData.loginedUser.updateUserInfo(
            familyName: userData[familyNameKey] as? String ?? "",
            name: userData[nameKey] as? String ?? "",
            email: email,
            password: userData[passwordKey] as? String ?? "",
            tickets: userData[ticketsKey] as? [Ticket] ?? []
        )
    }
}
