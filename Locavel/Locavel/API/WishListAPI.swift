//
//  WishListAPI.swift
//  Locavel
//
//  Created by 박희민 on 8/15/24.
//

import Moya
import Foundation

enum MyAPI {
    case addWishlist(placeId: String)
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.42.179:8080")!
    }

    var path: String {
        switch self {
        case .addWishlist(let placeId):
            return "/wishlist/\(placeId)"
            
        }
    }

    var method: Moya.Method {
        switch self {
        case .addWishlist:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .addWishlist:
            return .requestPlain // 요청 바디가 없는 경우 사용
        }
    }

    var headers: [String: String]? {
        switch self {
        case .addWishlist:
            return ["Authorization": "Bearer \(TokenManager.shared.accessToken)"]
        }
    }
}
