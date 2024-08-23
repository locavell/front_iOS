//
//  ReviewViewModel.swift
//  Locavel
//
//  Created by 박희민 on 8/22/24.
//
import Foundation
import Moya

class ReviewViewModel: ObservableObject {
    private let provider = MoyaProvider<ReviewAPI>()
    
    @Published var isSuccess: Bool = false
    @Published var message: String = ""
    
    func addReview(placeId: String, comment: String, rating: Double, completion: @escaping (Bool) -> Void) {
        provider.request(.addReview(placeId: placeId, comment: comment, rating: rating)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.handleSuccess(response: response, completion: completion)
                case .failure(let error):
                    self.handleFailure(error: error)
                    completion(false)
                }
            }
        }
    }
    
    private func handleSuccess(response: Response, completion: @escaping (Bool) -> Void) {
        print("HTTP 상태 코드: \(response.statusCode)")
        let responseString = String(data: response.data, encoding: .utf8)
        print("서버 응답 데이터: \(responseString ?? "응답 데이터 없음")")
        
        if responseString?.contains("<!DOCTYPE html>") == true {
            self.isSuccess = false
            self.message = "인증이 필요합니다. 로그인 페이지가 반환되었습니다.\n여기로 이동해 주세요."
            completion(false)
            return
        }
        
        do {
            let responseData = try JSONDecoder().decode(ReviewResponse.self, from: response.data)
            self.isSuccess = responseData.isSuccess
            self.message = responseData.message
            completion(responseData.isSuccess)
        } catch {
            print("디코딩 에러: \(error)\n원본 데이터: \(responseString ?? "응답 데이터 없음")")
            self.isSuccess = false
            self.message = "서버에서 반환된 데이터 처리 중 오류가 발생했습니다.\n다시 시도해 주시기 바랍니다."
            completion(false)
        }
    }
    
    private func handleFailure(error: MoyaError) {
        switch error {
        case .underlying(let nsError as NSError, _):
            if nsError.domain == NSURLErrorDomain {
                switch nsError.code {
                case NSURLErrorNotConnectedToInternet:
                    self.message = "인터넷 연결이 없습니다."
                case NSURLErrorTimedOut:
                    self.message = "요청 시간이 초과되었습니다."
                default:
                    self.message = "네트워크 오류: \(nsError.localizedDescription)"
                }
            } else {
                self.message = "네트워크 오류: \(nsError.localizedDescription)"
            }
        default:
            self.message = "알 수 없는 오류 발생: \(error.localizedDescription)"
        }
        self.isSuccess = false
    }
}

// 성공 응답 모델
struct ReviewResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReviewResult?
}

struct ReviewResult: Codable {
    let reviewId: Int
    let createdAt: String
}

// 에러 응답 모델
struct ErrorResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
