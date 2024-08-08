//
//  SpotViewModel.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//


import SwiftUI

class SpotViewModel: ObservableObject {
    @Published var spotLocalRestaurants: [SpotRestaurant] = [
        SpotRestaurant(image: "1", name: "상무초밥 송도직영점", hours: "영업 시간: 11:00 - 21:30", rating: 4.5),
        SpotRestaurant(image: "2", name: "건강밥상마니 송도점", hours: "영업 시간: 11:00 - 22:00", rating: 4.2),
        SpotRestaurant(image: "3", name: "송도 슈블라", hours: "영업 시간: 11:00 - 21:00", rating: 4.4)
    ]
    
    var spotFavoriteRestaurants: [SpotRestaurant] {
        spotLocalRestaurants.filter { $0.isFavorite }
    }
    
    func toggleFavorite(for restaurant: SpotRestaurant) {
        if let index = spotLocalRestaurants.firstIndex(where: { $0.id == restaurant.id }) {
            spotLocalRestaurants[index].isFavorite.toggle()
        }
    }
}




