//
//  UserDefaultsHelper.swift
//  Sai
//
//  Created by Claire on 12/18/24.
//

import Foundation

struct UserDefaultsHelper {
    private let userKey = "userData"
    private let familyNameKey = "familyName"
    private let nameKey = "name"
    private let emailKey = "email"
    private let passwordKey = "password"
    private let ticketsKey = "tickets"
    private let defaults = UserDefaults.standard
    

    func saveUserData(user: UserData) {

        var userDictionary = getUserDictionary()
        
        let userData: [String: Any] = [
            familyNameKey: user.familyName,
            nameKey: user.name,
            emailKey: user.email,
            passwordKey: user.password,
//            ticketsKey: user.tickets
        ]
        
        userDictionary[user.email] = userData
        
        defaults.set(userDictionary, forKey: userKey)
    }
    
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

}
