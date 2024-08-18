//
//  IdentifiableMapItem.swift
//  Locavel
//
//  Created by 김의정 on 8/13/24.
//

import Foundation
import MapKit

struct IdentifiableMapItem: Identifiable, Equatable {
    let id = UUID()
    let mapItem: MKMapItem

//    static func == (lhs: IdentifiableMapItem, rhs: IdentifiableMapItem) -> Bool {
//        lhs.id == rhs.id
//    }
}
