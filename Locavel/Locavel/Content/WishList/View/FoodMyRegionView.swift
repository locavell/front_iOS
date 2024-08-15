//
//  FoodMyRegionView.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import SwiftUI

struct FoodMyRegionView: View {
    let restaurants: [FoodRestaurant]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(restaurants) { restaurant in
                    VStack {
                        Image(restaurant.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 200)
                            .clipped()

                        Text(restaurant.name)
                            .font(.headline)
                            .multilineTextAlignment(.center)
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
                    }
                    .frame(width: 340)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom, 10)
                }
            }
            .padding()
        }
        .navigationTitle("내 지역 식당")
    }
}

struct FoodMyRegionView_Previews: PreviewProvider {
    static var previews: some View {
        FoodMyRegionView(restaurants: [
            FoodRestaurant(image: "1", name: "상무초밥 송도직영점", hours: "영업 시간: 11:00 - 21:30", rating: 4.5),
            FoodRestaurant(image: "2", name: "건강밥상마니 송도점", hours: "영업 시간: 11:00 - 22:00", rating: 4.2),
            FoodRestaurant(image: "3", name: "송도 슈블라", hours: "영업 시간: 11:00 - 21:00", rating: 4.4)
        ])
    }
}
