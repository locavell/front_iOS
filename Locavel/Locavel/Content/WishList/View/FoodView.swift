//
//  FoodView.swift
//  testbaki
//
//  Created by 박희민 on 7/18/24.
//
import SwiftUI

struct Restaurant: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var hours: String
    var rating: Double
}

struct FoodView: View {
    let localRestaurants = [
        Restaurant(image: "image1", name: "상무초밥 송도직영점", hours: "영업 시간: 11:00 - 21:30", rating: 4.5),
        Restaurant(image: "image2", name: "건강밥상마니 송도점", hours: "영업 시간: 11:00 - 22:00", rating: 4.2),
        Restaurant(image: "image3", name: "송도 슈블라", hours: "영업 시간: 11:00 - 21:00", rating: 4.4)
    ]
    
    let favoriteRestaurants = [
        Restaurant(image: "image4", name: "어나더레벨", hours: "서울특별시 중구 을지로12길 11 4층", rating: 4.0),
        Restaurant(image: "image5", name: "꽃지로", hours: "서울특별시 중구 을지로12길 16 2층", rating: 4.6),
        Restaurant(image: "image6", name: "행2PM8P", hours: "서울특별시 중구 을지로12길 15 3층", rating: 4.2)
    ]
    
    var body: some View {
        ScrollView(){
            VStack {
                Spacer()
                Text("내 지역")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(localRestaurants) { restaurant in
                            VStack {
                                Image(restaurant.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
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
                            .frame(width: 180)
                            .padding()
                        }
                    }
                }
                
                Spacer()
                
                Text("관심 지역")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(favoriteRestaurants) { restaurant in
                            VStack {
                                Image(restaurant.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
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
                            .frame(width: 180)
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FoodView()
}
