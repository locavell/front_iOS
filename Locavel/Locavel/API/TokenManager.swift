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

class TokenManager {
    static let shared = TokenManager()
    
    private init() {}
    
    var accessToken: String {
        // Return the access token here
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDM1MTM5NCwiZW1haWwiOiJlZDFAZXhhbXBsZS5jb20ifQ.f8GM60XHzHPq_06XQpn7_Rm7GobVlL4iV1QHBO-UPWNA9Xk04wNCZ9se3kg37R83m33ddBG7RWWYR7IuHT7G8Q"
    }
}
