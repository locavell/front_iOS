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
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDQxMTI3NSwiZW1haWwiOiJlZDFAZXhhbXBsZS5jb20ifQ.4HttlRHaDLX5mUrtU0R3siTqSZViEwtDiV0T0xKXDRfu9htqbyslbgj8gKPecoJLfV42dO3o_8m3XSFOc8macQ"
    }
}
