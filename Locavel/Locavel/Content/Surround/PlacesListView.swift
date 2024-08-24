//
//  PlacesListView.swift
//  Locavel
//
//  Created by 김의정 on 8/22/24.
//

import SwiftUI

struct PlacesListView: View {
    let latitude: Double
    let longitude: Double
    @State private var places: [PlaceListItem] = []
    @State private var errorMessage: String?
    @State private var selectedPlaceId: Int? // State to track selected place

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ForEach(places, id: \.placeId) { place in
                        PlaceRowView(place: place)
                            .onTapGesture {
                                selectedPlaceId = place.placeId
                            }
                        Divider()
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .onAppear {
            fetchPlaces()
        }
        .fullScreenCover(item: $selectedPlaceId) { placeId in
            PlaceDetailView(placeId: placeId)
        }
    }

    private func fetchPlaces() {
        let urlString = "https://api.locavel.site/api/places/recommend-results?latitude=\(latitude)&longitude=\(longitude)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(PlaceListResponse.self, from: data)
                    self.places = apiResponse.result
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct PlaceRowView: View {
    let place: PlaceListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) { // spacing을 5로 줄임
            Text(place.name)
                .font(.headline)
                .foregroundColor(.black)

            HStack {
                Text("영업중")  // Business status
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("리뷰 \(place.reviewCount)")  // Review count
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                        .font(.subheadline)
                    Text("\(place.rating, specifier: "%.1f")")  // Star rating
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
            }

            if !place.reviewImgList.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 5) {
                        ForEach(place.reviewImgList, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 110)
                                        .clipped()
                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(width: 80, height: 80)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding(.top, 2) // 이미지 위쪽에 아주 작은 padding 추가
            }
        }
        .padding(8)
    }
}

struct PlaceListResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [PlaceListItem]
}

struct PlaceListItem: Codable {
    let placeId: Int
    let name: String
    let address: String
    let rating: Double
    let reviewCount: Int
    let reviewImgList: [String]
}

extension Int: Identifiable {
    public var id: Int { self }
}
