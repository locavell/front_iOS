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
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDQzNjYxOSwiZW1haWwiOiJoZWVtaW5nQGV4YW1wbGUuY29tIn0.X3thwXvZ6MXwzN3j0zrN2htYWvDWgSKI3aU9oGvDoOGlxkAkTi_wGGtXvJXlR3vWdT-R5szP2OIdjp30tP6FIw"
    }
}
