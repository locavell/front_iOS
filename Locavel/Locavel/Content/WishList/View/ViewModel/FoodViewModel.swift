import SwiftUI
import Moya

class FoodViewModel: ObservableObject {
    let provider = MoyaProvider<MyAPI>()
    
    @Published var localRestaurants: [FoodRestaurant] = []
    @Published var favoriteRestaurants: [FoodRestaurant] = []

    // 추천 레스토랑 데이터를 가져오는 함수
    func getRecommendedRestaurants(latitude: Double, longitude: Double) {
        provider.request(.getRecommendedRestaurants(latitude: latitude, longitude: longitude)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.handleRecommendedRestaurantsResponse(response: response)
                case .failure(let error):
                    print("API 요청 실패: \(error.localizedDescription)")
                }
            }
        }
    }

    private func handleRecommendedRestaurantsResponse(response: Response) {
        do {
            let decoder = JSONDecoder()
            let jsonResponse = try decoder.decode(RecommendedRestaurantsResponse.self, from: response.data)

            if jsonResponse.isSuccess {
                self.localRestaurants = jsonResponse.result.map { place in
                    FoodRestaurant(
                        id: place.placeId,
                        image: place.reviewImgList.first ?? "", // 첫 번째 이미지를 사용하거나 기본 이미지 사용
                        name: place.name,
                        hours: "", // 여기에 실제 운영 시간을 넣을 수 있습니다
                        rating: place.rating,
                        isFavorite: self.isFavorite(placeId: place.placeId)
                    )
                }
                saveFavoriteStatus()
            } else {
                print("추천 레스토랑 조회 실패: \(jsonResponse.message ?? "")")
            }
        } catch {
            print("JSON 디코딩 에러: \(error.localizedDescription)")
            if let responseString = String(data: response.data, encoding: .utf8) {
                print("에러 발생 시 응답 데이터: \(responseString)")
            } else {
                print("응답 데이터를 문자열로 변환하는 데 실패했습니다.")
            }
        }
    }

    func addWishlist(placeId: String, completion: @escaping (Bool) -> Void) {
        provider.request(.addWishlist(placeId: placeId)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.handleSuccess(response: response, placeId: placeId, completion: completion)
                case .failure(let error):
                    print("API 요청 실패: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }

    func removeWishlist(placeId: String, completion: @escaping (Bool) -> Void) {
        provider.request(.removeWishlist(placeId: placeId)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.handleRemoveSuccess(response: response, placeId: placeId, completion: completion)
                case .failure(let error):
                    print("API 요청 실패: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }

    private func handleSuccess(response: Response, placeId: String, completion: @escaping (Bool) -> Void) {
        print("HTTP 상태 코드: \(response.statusCode)")
        
        do {
            let decoder = JSONDecoder()
            let jsonResponse = try decoder.decode(WishlistResponse.self, from: response.data)

            print("응답 코드: \(jsonResponse.code)")
            print("응답 메시지: \(jsonResponse.message)")

            if jsonResponse.isSuccess {
                // 레스토랑을 favoriteRestaurants에 추가
                if let restaurant = self.localRestaurants.first(where: { "\($0.id)" == placeId }) {
                    if !self.favoriteRestaurants.contains(where: { $0.id == restaurant.id }) {
                        self.favoriteRestaurants.append(restaurant)
                    }

                    // 레스토랑의 isFavorite 상태를 업데이트
                    if let index = self.localRestaurants.firstIndex(where: { $0.id == Int(placeId) }) {
                        self.localRestaurants[index].isFavorite = true
                    }
                }

                saveFavoriteStatus()
            }

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

    private func handleRemoveSuccess(response: Response, placeId: String, completion: @escaping (Bool) -> Void) {
        do {
            let decoder = JSONDecoder()
            let jsonResponse = try decoder.decode(WishlistResponse.self, from: response.data)

            if jsonResponse.isSuccess {
                if let index = self.favoriteRestaurants.firstIndex(where: { "\($0.id)" == placeId }) {
                    self.favoriteRestaurants.remove(at: index)
                }

                if let index = self.localRestaurants.firstIndex(where: { $0.id == Int(placeId) }) {
                    self.localRestaurants[index].isFavorite = false
                }

                saveFavoriteStatus()
            }

            completion(jsonResponse.isSuccess)
        } catch {
            print("JSON 디코딩 에러: \(error.localizedDescription)")
            completion(false)
        }
    }

    private func saveFavoriteStatus() {
        let favoriteIds = localRestaurants.filter { $0.isFavorite }.map { String($0.id) }
        UserDefaults.standard.set(favoriteIds, forKey: "FavoriteRestaurantIds")
    }

    private func isFavorite(placeId: Int) -> Bool {
        guard let favoriteIds = UserDefaults.standard.array(forKey: "FavoriteRestaurantIds") as? [String] else { return false }
        return favoriteIds.contains(String(placeId))
    }
}


// JSON 응답에 맞는 Codable 모델
struct WishlistResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String?
}


struct RecommendedRestaurantsResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String?
    let result: [FoodPlace]
}

struct FoodPlace: Codable {
    let placeId: Int
    let name: String
    let address: String
    let rating: Double
    let reviewCount: Int
    let reviewImgList: [String]
}
