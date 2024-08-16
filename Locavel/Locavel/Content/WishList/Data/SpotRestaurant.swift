//
//  SpotRestaurant.swift
//  Locavel
//
//  Created by 박희민 on 7/29/24.
//

import Foundation

struct SpotRestaurant: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let hours: String
    let rating: Double
    var isFavorite: Bool = false
}
