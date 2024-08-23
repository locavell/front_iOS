//
//  SpotRestaurant.swift
//  Locavel
//
//  Created by 박희민 on 7/29/24.
//

import Foundation

struct SpotRestaurant: Identifiable, Codable {
    var id: Int
    var image: String
    var name: String
    var hours: String
    var rating: Double
    var isFavorite: Bool
}
