//
//  ReviewAPI.swift
//  Locavel
//
//  Created by 박희민 on 8/22/24.
//

import Foundation
import Moya

enum ReviewAPI {
    case addReview(placeId: String, comment: String, rating: Double)
    case MyReview
}

extension ReviewAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.locavel.site")!
    }
    
    var path: String {
        switch self {
        case .addReview(let placeId, _, _):
            return "/api/reviews/\(placeId)"
        case .MyReview:
            return "/api/reviews/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addReview:
            return .post
        case .MyReview:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .addReview(_, let comment, let rating):
            let jsonObject: [String: Any] = ["comment": comment, "rating": rating]
            let jsonData = try! JSONSerialization.data(withJSONObject: jsonObject, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let formData: [MultipartFormData] = [
                MultipartFormData(provider: .data(jsonString.data(using: .utf8)!), name: "request")
            ]
            return .uploadMultipart(formData)
        case .MyReview:
            return .requestPlain
        }
    }

    
    var headers: [String: String]? {
        switch self{
        case .addReview:
            var headers = ["Content-Type": "multipart/form-data"]
            let accessToken = TokenManager.shared.accessToken
            headers["Authorization"] = "Bearer \(accessToken)"
            return headers
        case .MyReview:
            var headers = ["Content-Type": "application/json"]
            let accessToken = TokenManager.shared.accessToken
            headers["Authorization"] = "Bearer \(accessToken)"
            return headers
        }
    }
}
