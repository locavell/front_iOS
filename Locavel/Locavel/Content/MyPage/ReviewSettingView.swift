//
//  ReviewSettingView.swift
//  Locavel
//
//  Created by 김경서 on 8/24/24.
//
import SwiftUI
import Moya

// 리뷰 모델 정의
struct Review: Identifiable {
    let id: Int
    let placeName: String
    let address: String
    let reviewImages: [String]
    let comment: String
    let createdAt: String
    let rating: Int
}
struct ReviewSettingView: View {
    @State private var reviews: [Review] = []
    @State private var isLoading = false
    @State private var currentPage = 1

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if reviews.isEmpty {
                Text("등록된 리뷰가 없습니다.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                ScrollView {
                    ForEach(reviews) { review in
                        ReviewCardView(review: review)
                    }
                }
            }
        }
        .onAppear {
            fetchReviews(page: currentPage)
        }
        .navigationTitle("리뷰 관리")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("편집") {
                // 편집 액션 처리
            }
        }
    }

    private func fetchReviews(page: Int) {
        isLoading = true
        let provider = MoyaProvider<ReviewAPI>()
        provider.request(.MyReview(page: page)) { result in
            isLoading = false
            switch result {
            case .success(let response):
                do {
                    if let responseData = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any],
                       let result = responseData["result"] as? [String: Any],
                       let reviewList = result["reviewList"] as? [[String: Any]] {
                        
                        DispatchQueue.main.async {
                            self.reviews = reviewList.compactMap { data in
                                guard let reviewId = data["reviewId"] as? Int,
                                      let placeName = data["placeName"] as? String,
                                      let address = data["address"] as? String,
                                      let reviewImages = data["reviewImgList"] as? [String],
                                      let comment = data["comment"] as? String,
                                      let createdAt = data["createdAt"] as? String,
                                      let rating = data["rating"] as? Int else {
                                    print("데이터 파싱 오류: \(data)")
                                    return nil
                                }
                                print("리뷰 파싱 성공: \(placeName), \(rating)")
                                return Review(id: reviewId, placeName: placeName, address: address, reviewImages: reviewImages, comment: comment, createdAt: createdAt, rating: rating)
                            }
                        }
                    }
                } catch {
                    print("리뷰 파싱 실패: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("리뷰 데이터 가져오기 실패: \(error.localizedDescription)")
            }
        }
    }
}

struct ReviewCardView: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "fork.knife.circle")
                    .foregroundColor(.red)
                Text(review.placeName)
                    .font(.headline)
                Spacer()
                Button("수정하기") {
                    // 수정 액션 처리
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            Text("등록날짜: \(formatDate(review.createdAt))")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("주소: \(review.address)")
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Text("별점")
                    .font(.subheadline)
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < review.rating ? "star.fill" : "star")
                            .foregroundColor(index < review.rating ? .yellow : .gray)
                    }
                }
            }
            Text("코멘트: \(review.comment)")
                .font(.subheadline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(review.reviewImages, id: \.self) { imageUrl in
                        // URL로부터 이미지를 로드하는 AsyncImage 사용
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy.MM.dd"
            return outputFormatter.string(from: date)
        }
        return dateString
    }
}

#Preview {
    ReviewSettingView()
}
