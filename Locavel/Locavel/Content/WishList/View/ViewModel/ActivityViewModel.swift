//
//  ActivityViewModel.swift
//  Locavel
//
//  Created by 박희민 on 8/20/24.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var spotLocalRestaurants: [ActivityRestaurant] = [
        ActivityRestaurant(image: "1", name: "상무초밥 송도직영점", hours: "영업 시간: 11:00 - 21:30", rating: 4.5),
        ActivityRestaurant(image: "2", name: "건강밥상마니 송도점", hours: "영업 시간: 11:00 - 22:00", rating: 4.2),
        ActivityRestaurant(image: "3", name: "송도 슈블라", hours: "영업 시간: 11:00 - 21:00", rating: 4.4)
    ]
    
    var spotFavoriteRestaurants: [ActivityRestaurant] {
        spotLocalRestaurants.filter { $0.isFavorite }
    }
    
    func toggleFavorite(for restaurant: ActivityRestaurant) {
        if let index = spotLocalRestaurants.firstIndex(where: { $0.id == restaurant.id }) {
            spotLocalRestaurants[index].isFavorite.toggle()
        }
    }
}

