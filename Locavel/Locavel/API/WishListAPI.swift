//
//  WishListAPI.swift
//  Locavel
//
//  Created by 박희민 on 8/15/24.
//

import Foundation
import Moya

enum MyAPI {
    case addWishlist(placeId: String?)
    case removeWishlist(placeId: String?)
    case getRecommendedRestaurants(latitude: Double, longitude: Double)
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.locavel.site")!
    }

    var path: String {
        switch self {
        case .addWishlist(let placeId):
            return "/api/places/\(placeId ?? "")/wish-list"
        case .removeWishlist(let placeId):
            return "/api/places/\(placeId ?? "")/wish-list"
        case .getRecommendedRestaurants:
            return "/api/places/recommend-results"
        }
    }

    var method: Moya.Method {
        switch self {
        case .addWishlist:
            return .post
        case .removeWishlist:
            return .delete
        case .getRecommendedRestaurants:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .addWishlist(let placeId), .removeWishlist(let placeId):
            return .requestParameters(parameters: ["placeId": placeId ?? ""], encoding: JSONEncoding.default)
        case .getRecommendedRestaurants(let latitude, let longitude):
            return .requestParameters(parameters: ["latitude": latitude, "longitude": longitude], encoding: URLEncoding.queryString)
        }
    }



    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]

        // 인증 토큰을 헤더에 추가
       
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDMzMDc0OSwiZW1haWwiOiJlZDNAZXhhbXBsZS5jb20ifQ.mSnO6pInswY3O-fZNX9bsDH-zgFbmoQWZMBvetNnHT3DMiZfQqqB0FmVJf8DDXinwEdJen8XqJtsJeyvWSUgZw"
        let refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MjU1MzY3NDl9.qRmsAR6FZ_CXpkW2mAPS4W_UzZVvm8adDf-47hkqmSQar7RXoXQABw8A89zfpJwHcn0g35iZOm4QJetfVvqfYA"

        // TokenManager에 토큰 설정
        TokenManager.shared.accessToken = accessToken
        TokenManager.shared.refreshToken = refreshToken
        if let accessToken = TokenManager.shared.accessToken {
            headers["Authorization"] = "Bearer \(accessToken)"
        }

        return headers
    }
}

let provider = MoyaProvider<MyAPI>(plugins: [NetworkLoggerPlugin()])

