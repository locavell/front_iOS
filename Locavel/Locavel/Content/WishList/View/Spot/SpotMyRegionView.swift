//
//  SpotMyRegionView.swift
//  Locavel
//
//  Created by 박희민 on 7/26/24.
//
//
import SwiftUI

struct SpotMyRegionView: View {
    let restaurants: [SpotRestaurant]

    var body: some View {
        ZStack(alignment: .bottom) {
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
            
        }
        .navigationTitle("내 지역 식당")
    }
}
