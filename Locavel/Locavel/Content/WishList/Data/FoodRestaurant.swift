//
//  Restaurant.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import Foundation

struct FoodRestaurant: Identifiable, Codable {
    var id: Int
    var image: String
    var name: String
    var hours: String
    var rating: Double
    var isFavorite: Bool
}
