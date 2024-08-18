//
//  RegisterReviewView.swift
//  Locavel
//
//  Created by 김의정 on 8/18/24.
//

import SwiftUI

struct RegisterReviewView: View {
    
    struct Place: Identifiable {
        let id = UUID()
        let placeName: String
        let reviews: Int
        let rating: Double
        let userRating: Double
        let images: [String]
    }
    
    // Sample data for testing
    let places = [
        Place(placeName: "송도컨벤시아", reviews: 874, rating: 4.22, userRating: 3.41, images: [
            "place1-1", "place1-2", "place1-3", "place1-4"
        ]),
        Place(placeName: "제일면옥 송도점", reviews: 998, rating: 4.59, userRating: 4.41, images: [
            "place2-1", "place2-2", "place2-3"
        ]),
        Place(placeName: "풍월", reviews: 924, rating: 4.32, userRating: 4.21, images: [
            "place3-1", "place3-2", "place3-3", "place3-4"
        ]),
        Place(placeName: "이아", reviews: 995, rating: 4.42, userRating: 3.45, images: [
            "place4-1", "place4-2", "place4-3", "place4-4"
        ])
    ]
    
    var body: some View {
        NavigationView {
            List(places) { place in
                VStack(alignment: .leading) {
                    HStack {
                        Text(place.placeName)
                            .font(.headline)
                        Spacer()
                        Text("리뷰 \(place.reviews)")
                            .font(.subheadline)
                        Text("★ \(String(format: "%.2f", place.rating))")
                            .foregroundColor(.red)
                            .font(.subheadline)
                        Text("현지인 평점 \(String(format: "%.2f", place.userRating))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(place.images, id: \.self) { image in
                                Image(image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("내 주변 추천 장소")
            .searchable(text: .constant(""))
        }
    }
}
