//
//  Restaurant.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import SwiftUI

struct FoodRestaurant: Identifiable {
    let id : Int
    let image: String
    let name: String
    let hours: String
    let rating: Double
    var isFavorite: Bool = false
}
