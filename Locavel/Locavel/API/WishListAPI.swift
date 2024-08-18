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

// Extend the API enum to conform to `TargetType`
extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.42.179:8080")!
    }

    var path: String {
        switch self {
        case .addWishlist:
            return "/api/wishlist"
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
        return ["Content-Type": "application/json"]
    }
}

let provider = MoyaProvider<MyAPI>()

func addToWishlist(placeId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    provider.request(.addWishlist(placeId: placeId)) { result in
        switch result {
        case .success(let response):
            // Check the HTTP status code
            switch response.statusCode {
            case 200:
                print("Added to wishlist successfully.")
                completion(.success(()))
            case 401:
                print("Unauthorized. Please log in.")
                completion(.failure(NSError(domain: "APIError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized. Please log in."])))
            default:
                print("Failed with status code: \(response.statusCode)")
                completion(.failure(NSError(domain: "APIError", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed with status code \(response.statusCode)"])))
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
            completion(.failure(error))
        }
    }
}
