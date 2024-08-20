//
//  MapView.swift
//  Locavel
//
//  Created by 김의정 on 8/12/24.
//

//import SwiftUI
//import MapKit
//
//struct MapView: UIViewRepresentable {
//    @Binding var region: MKCoordinateRegion
//    @Binding var selectedPlace: IdentifiableMapItem?
//    @Binding var places: [Place]
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = true
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        mapView.setRegion(region, animated: true)
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.setRegion(region, animated: true)
//        updateMapAnnotations(mapView: uiView)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    private func updateMapAnnotations(mapView: MKMapView) {
//        mapView.removeAnnotations(mapView.annotations)
//        
//        if let place = selectedPlace {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = place.mapItem.placemark.coordinate
//            annotation.title = place.mapItem.name
//            mapView.addAnnotation(annotation)
//        }
//        
//        for place in places {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
//            annotation.title = place.category
//            mapView.addAnnotation(annotation)
//        }
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//            let southWest = mapView.convert(CGPoint(x: 0, y: mapView.frame.height), toCoordinateFrom: mapView)
//            let northEast = mapView.convert(CGPoint(x: mapView.frame.width, y: 0), toCoordinateFrom: mapView)
//
//            let urlString = "https://api.locavel.site/api/places/map?swLat=\(southWest.latitude)&swLng=\(southWest.longitude)&neLat=\(northEast.latitude)&neLng=\(northEast.longitude)"
//
//            guard let url = URL(string: urlString) else { return }
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let data = data {
//                    do {
//                        let apiResponse = try JSONDecoder().decode(PlaceResponse.self, from: data)
//                        DispatchQueue.main.async {
//                            self.parent.places = apiResponse.result
//                            self.parent.updateMapAnnotations(mapView: mapView)
//                        }
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                    }
//                }
//            }.resume()
//        }
//    }
//}
//
//struct Place: Codable, Identifiable {
//    let placeId: Int
//    let latitude: Double
//    let longitude: Double
//    let category: String
//    let categoryImgUrl: String
//
//    var id: Int { placeId }
//}
//
//struct PlaceResponse: Codable {
//    let isSuccess: Bool
//    let code: String
//    let message: String
//    let result: [Place]
//}

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var places: [Place]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        // 초기 데이터 로딩
        context.coordinator.fetchPlaces(mapView: view)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            fetchPlaces(mapView: mapView)
        }
        
        func fetchPlaces(mapView: MKMapView) {
            let southWest = mapView.convert(CGPoint(x: 0, y: mapView.frame.height), toCoordinateFrom: mapView)
            let northEast = mapView.convert(CGPoint(x: mapView.frame.width, y: 0), toCoordinateFrom: mapView)

            let urlString = "https://api.locavel.site/api/places/map?swLat=\(southWest.latitude)&swLng=\(southWest.longitude)&neLat=\(northEast.latitude)&neLng=\(northEast.longitude)"

            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let apiResponse = try JSONDecoder().decode(PlaceResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.parent.places = apiResponse.result
                            self.parent.updateMapAnnotations(mapView: mapView)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }
    
    func updateMapAnnotations(mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = places.map { place -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            annotation.title = place.category
            return annotation
        }
        mapView.addAnnotations(annotations)
    }
}

struct PlaceResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [Place]
}

struct Place: Codable {
    let placeId: Int
    let latitude: Double
    let longitude: Double
    let category: String
    let categoryImgUrl: String
}
