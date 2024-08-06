//
//  NaverMap.swift
//  Locavel
//
//  Created by 김의정 on 8/4/24.
//

import SwiftUI
import NMapsMap

struct NaverMap: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
//
//    func setmark(lat: Double, lng: Double) {
//        Coordinator.shared.setMarker(lat: lat, lng: lng)
//    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
    
}
