//
//  TokenManager.swift
//  Locavel
//
//  Created by 박희민 on 8/15/24.
//

//import Foundation
//
//class TokenManager {
//    static let shared = TokenManager()
//
//    private let userDefaults = UserDefaults.standard
//    private let accessTokenKey = "accessToken"
//    private let refreshTokenKey = "refreshToken"
//
//    var accessToken: String? {
//        get {
//            return userDefaults.string(forKey: accessTokenKey)
//        }
//        set {
//            userDefaults.setValue(newValue, forKey: accessTokenKey)
//        }
//    }
//
//    var refreshToken: String? {
//        get {
//            return userDefaults.string(forKey: refreshTokenKey)
//        }
//        set {
//            userDefaults.setValue(newValue, forKey: refreshTokenKey)
//        }
//    }
//
//    private init() {}
//    
//    func clearTokens() {
//        userDefaults.removeObject(forKey: accessTokenKey)
//        userDefaults.removeObject(forKey: refreshTokenKey)
//    }
//}

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private init() {}
    
    var accessToken: String {
        // Return the access token here(이건 ed3@example.com 계정에 대한 accessToken임)
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDIyNzM4MSwiZW1haWwiOiJlZDNAZXhhbXBsZS5jb20ifQ.Ytq5l-uGMqbMCHsuAJS3Zm6I2c6gwHG2Ls-1dbiMtJlIIfkNC6TaW7txHZUJC86dT7WBAveL_KES-fEkLok_GA"
    }
}
