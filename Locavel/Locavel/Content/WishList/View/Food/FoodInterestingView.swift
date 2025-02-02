//
//  FoodInterestingView.swift
//  Locavel
//
//  Created by 박희민 on 8/19/24.
//

import SwiftUI

struct FoodInterestingView: View {
    let restaurants: [FoodRestaurant]

    var body: some View {
        List(restaurants) { restaurant in
            VStack(alignment: .leading) {
                Image(restaurant.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()

                Text(restaurant.name)
                    .font(.headline)
                    .padding(.top, 5)

                Text(restaurant.hours)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(restaurant.rating) ? "star.fill" : "star")
                            .foregroundColor(index < Int(restaurant.rating) ? .yellow : .gray)
                    }

                    Text(String(format: "%.1f", restaurant.rating))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
            }
            .padding()
        }
        .navigationTitle("관심 지역")
    }
}

#Preview {
    FoodInterestingView(restaurants: [
        FoodRestaurant(id: 1, image: "1", name: "상무초밥 송도직영점", hours: "영업 시간: 11:00 - 21:30", rating: 4.5, isFavorite: true),
        FoodRestaurant(id: 2, image: "2", name: "건강밥상마니 송도점", hours: "영업 시간: 11:00 - 22:00", rating: 4.2, isFavorite: true),
        FoodRestaurant(id: 3, image: "3", name: "송도 슈블라", hours: "영업 시간: 11:00 - 21:00", rating: 4.4, isFavorite: true)
    ])
}



