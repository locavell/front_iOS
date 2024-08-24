//
//  AroundPlacesView.swift
//  Locavel
//
//  Created by 김의정 on 8/23/24.
//

import SwiftUI

struct AroundPlace: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    let overallRating: Double
    let localsRating: Double
    let travelersRating: Double
}

struct AroundPlacesView: View {
    
    let places: [AroundPlace] = [
        AroundPlace(
            name: "어나더레벨",
            description: "힘지로에 어울리는 분위기 술집",
            imageName: "place_image1",
            overallRating: 4.0,
            localsRating: 3.0,
            travelersRating: 5.0
        ),
        AroundPlace(
            name: "을지맥옥",
            description: "을지로 최고 힙한 술집",
            imageName: "place_image2",
            overallRating: 4.2,
            localsRating: 3.0,
            travelersRating: 5.0
        ),
        // Add more Place instances as needed
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("주변 장소")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            ForEach(places) { place in
                VStack(alignment: .leading) {
                    HStack {
                        Image(place.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .font(.headline)
                            Text(place.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            HStack {
                                aRatingView(label: "전체", rating: place.overallRating)
                                aRatingView(label: "현지인", rating: place.localsRating)
                                aRatingView(label: "여행자", rating: place.travelersRating)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    
                    Divider()
                }
            }
        }
        .padding(.top, 20)
    }
}

struct aRatingView: View {
    let label: String
    let rating: Double
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(Color("AccentColor"))
            VStack {
                Text(label)
                    .font(.caption)
                Text(String(format: "%.1f", rating))
                    .font(.caption)
            }
        }
    }
}
