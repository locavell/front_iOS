//
//  ActivityRestaurant.swift
//  Locavel
//
//  Created by 박희민 on 8/20/24.
//
import Foundation

struct ActivityRestaurant: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var hours: String
    var rating: Double
    var isFavorite: Bool = false
}
