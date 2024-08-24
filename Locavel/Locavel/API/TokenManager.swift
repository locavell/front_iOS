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
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDQ3OTU3NiwiZW1haWwiOiJlZDFAZXhhbXBsZS5jb20ifQ.TjDRgklQoEOSIX7CL-VpZNxU2CpeFmFdQo-V3NM0LDBo2HEv5j1wpRNhkIcf-3ohBwV9TfIJu2yDSWvA1GciQA"
    }
}
