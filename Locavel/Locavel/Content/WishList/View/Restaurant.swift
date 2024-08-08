//
//  Restaurant.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import SwiftUI

struct Restaurant: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let hours: String
    let rating: Double
    var isFavorite: Bool = false
}
