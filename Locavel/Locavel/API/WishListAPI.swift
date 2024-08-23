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
        let accessToken = TokenManager.shared.accessToken
        headers["Authorization"] = "Bearer \(accessToken)"
        return headers
    }
}

let provider = MoyaProvider<MyAPI>(plugins: [NetworkLoggerPlugin()])
