//
//  UserDefault.swift
//  building management
//
//  Created by SAIL on 09/10/23.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard

    private init() {}

    // MARK: - Define Keys for Your Data
    private let userIdKey = "UserId"
    private let userProfileKay = "UserProfile"
    private let userAgeKey = "UserAge"

    // MARK: - Save Data
    func saveUserId(_ name: String) {
        userDefaults.set(name, forKey: userIdKey)
    }
    
    func saveUserProfile(_ name: String) {
        userDefaults.set(name, forKey: userProfileKay)
    }

    func saveUserAge(_ age: Int) {
        userDefaults.set(age, forKey: userAgeKey)
    }

    // MARK: - Retrieve Data
    func getUserId() -> String? {
        return userDefaults.string(forKey: userIdKey)
    }
    
    func getUserProfile() -> String? {
        return userDefaults.string(forKey: userProfileKay)
    }

    func getUserAge() -> Int {
        return userDefaults.integer(forKey: userAgeKey)
    }

    // MARK: - Remove Data (if needed)
    func removeUserData() {
        userDefaults.removeObject(forKey: userIdKey)
        userDefaults.removeObject(forKey: userAgeKey)
    }
}

