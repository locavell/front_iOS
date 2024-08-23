//
//  ReviewAPI.swift
//  Locavel
//
//  Created by 박희민 on 8/22/24.
//

import Foundation
import Moya

enum ReviewAPI {
    case addReview(placeId: String?, comment: String, rating: Double)
}

extension ReviewAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.locavel.site")!
    }
    
    var path: String {
        switch self {
        case .addReview(let placeId, _, _):
            return "/api/reviews/\(placeId ?? "")"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addReview:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .addReview(_, let comment, let rating):
            let parameters: [String: Any] = ["comment": comment, "rating": rating]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        let accessToken = TokenManager.shared.accessToken
        headers["Authorization"] = "Bearer \(accessToken)"
        return headers
    }
}
