//
//  TokenManager.swift
//  Locavel
//
//  Created by 박희민 on 8/15/24.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()

    private let userDefaults = UserDefaults.standard
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"

    var accessToken: String? {
        get {
            return userDefaults.string(forKey: accessTokenKey)
        }
        set {
            userDefaults.setValue(newValue, forKey: accessTokenKey)
        }
    }

    var refreshToken: String? {
        get {
            return userDefaults.string(forKey: refreshTokenKey)
        }
        set {
            userDefaults.setValue(newValue, forKey: refreshTokenKey)
        }
    }

    private init() {}
    
    func clearTokens() {
        userDefaults.removeObject(forKey: accessTokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)
    }
}
