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
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.locavel.site")!
    }

    var path: String {
            switch self {
            case .addWishlist(let placeId):
                return "/api/places/\(placeId ?? "")/wish-list"
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
        case .addWishlist(let placeId):
            return .requestParameters(parameters: ["placeId": placeId ?? ""], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]

        // 인증 토큰을 헤더에 추가
       
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcyNDI1NDExNiwiZW1haWwiOiJlZDNAZXhhbXBsZS5jb20ifQ.kPpyBjKtL0rEcFprusJBBUpGLgVQhy8cgvX_JanI_BGCjIvdRNhafdB63v7MvAFq401S4_JGaQ70cIBXWDlEQg"
        let refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MjU0NjAxMTZ9.DlcKY8lFdiCAqQeiYiDmqkdM0N6rs3z6TzuMHy4A4kCE388LpBtzT2Fc0OP_-V3RfuOB4JnmQB3Vprc4VS3Hkg"

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

//
//let provider = MoyaProvider<MyAPI>()
//
//func addToWishlist(placeId: String, completion: @escaping (Result<Void, Error>) -> Void) {
//    provider.request(.addWishlist(placeId: placeId)) { result in
//        switch result {
//        case .success(let response):
//            // Check the HTTP status code
//            switch response.statusCode {
//            case 200:
//                print("Added to wishlist successfully.")
//                completion(.success(()))
//            case 401:
//                print("Unauthorized. Please log in.")
//                completion(.failure(NSError(domain: "APIError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized. Please log in."])))
//            default:
//                print("Failed with status code: \(response.statusCode)")
//                completion(.failure(NSError(domain: "APIError", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed with status code \(response.statusCode)"])))
//            }
//        case .failure(let error):
//            print("Request failed with error: \(error)")
//            completion(.failure(error))
//        }
//    }
//}
