//
//  PlacesListView.swift
//  Locavel
//
//  Created by 김의정 on 8/22/24.
//

import Foundation
import SwiftUI

struct PlacesListView: View {
    let places: [RecommendedPlace]

    var body: some View {
        NavigationView {
            List(places, id: \.placeId) { place in
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                    Text(place.address)
                        .font(.subheadline)
                    HStack {
                        Text("Rating: \(place.rating, specifier: "%.1f")")
                        Text("Reviews: \(place.reviewCount)")
                    }
                    .font(.footnote)
                }
            }
            .navigationTitle("Place List")
        }
    }
}

