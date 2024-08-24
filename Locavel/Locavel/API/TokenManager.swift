//
//  TokenManager.swift
//  Locavel
//
//  Created by 박희민 on 8/15/24.
//

class TokenManager {
    static let shared = TokenManager()
    
    private init() {}
    
    var accessToken: String {
        // Return the access token here
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDQ4MjAzNiwiZW1haWwiOiJoZWVtaW5nQGV4YW1wbGUuY29tIn0.hzez2g36LdG7WZg0XchNZSpEu_8kq95lu3qPjqk2_GVJEHhHganMYq-GqkNrSl6ZfxBZJfjAI0b3Wz71sRjyjg"
    }
}
