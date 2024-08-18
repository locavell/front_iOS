//
//  RestaurantViewModel.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//
import Moya
import SwiftUI

class FoodViewModel: ObservableObject {
    let provider = MoyaProvider<MyAPI>()
    
    @Published var localRestaurants: [FoodRestaurant] = [
        FoodRestaurant(image: "1", name: "상무초밥 송도직영점", hours: "영업 시간: 11:00 - 21:30", rating: 4.5),
        FoodRestaurant(image: "2", name: "건강밥상마니 송도점", hours: "영업 시간: 11:00 - 22:00", rating: 4.2),
        FoodRestaurant(image: "3", name: "송도 슈블라", hours: "영업 시간: 11:00 - 21:00", rating: 4.4)
    ]
    
    @Published var favoriteRestaurants: [FoodRestaurant] = []

    func addWishlist(placeId: String, completion: @escaping (Bool) -> Void) {
        provider.request(.addWishlist(placeId: placeId)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.handleSuccess(response: response, completion: completion)
                    
                case .failure(let error):
                    print("API 요청 실패: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }

    private func handleSuccess(response: Response, completion: @escaping (Bool) -> Void) {
        do {
            let decoder = JSONDecoder()
            let jsonResponse = try decoder.decode(WishlistResponse.self, from: response.data)
            
            print("응답 코드: \(jsonResponse.code)")
            print("응답 메시지: \(jsonResponse.message)")
            
            completion(jsonResponse.isSuccess)
            
        } catch {
            print("JSON 디코딩 에러: \(error.localizedDescription)")
            if let responseString = String(data: response.data, encoding: .utf8) {
                print("에러 발생 시 응답 데이터: \(responseString)")
            } else {
                print("응답 데이터를 문자열로 변환하는 데 실패했습니다.")
            }
            completion(false)
        }
    }

}

// JSON 응답에 맞는 Codable 모델
struct WishlistResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String?
}
