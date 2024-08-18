//
//  MapView.swift
//  Locavel
//
//  Created by 김의정 on 8/12/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var selectedPlace: IdentifiableMapItem?
    @Binding var places: [Place]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        updateMapAnnotations(mapView: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func updateMapAnnotations(mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        
        // 선택된 장소가 있을 경우 어노테이션 추가
        if let place = selectedPlace {
            let annotation = MKPointAnnotation()
            annotation.coordinate = place.mapItem.placemark.coordinate
            annotation.title = place.mapItem.name
            mapView.addAnnotation(annotation)
        }
        // 만약 등록된 장소들 보는데 방해되면 이부분만 지우면 댐
        
        for place in places {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            annotation.title = place.category
            mapView.addAnnotation(annotation)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
//        func fetchPlaces(swLat: Double, swLng: Double, neLat: Double, neLng: Double) {
//            let url = URL(string: "https://yourapi.com/endpoint?swLat=\(swLat)&swLng=\(swLng)&neLat=\(neLat)&neLng=\(neLng)")!
//            var request = URLRequest(url: url)
//            request.setValue("accessToken", forHTTPHeaderField: "Authorization")
//            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                // Handle response and update UI
//            }.resume()
//        } // 위치 가져올 때 accessToken 적용해서 사용하는 함수 예시

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let southWest = mapView.convert(CGPoint(x: 0, y: mapView.frame.height), toCoordinateFrom: mapView)
            let northEast = mapView.convert(CGPoint(x: mapView.frame.width, y: 0), toCoordinateFrom: mapView)

            let urlString = "http://43.203.42.179:8080/api/places/map?swLat=\(southWest.latitude)&swLng=\(southWest.longitude)&neLat=\(northEast.latitude)&neLng=\(northEast.longitude)"

            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
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
}

struct Place: Codable, Identifiable {
    let placeId: Int
    let latitude: Double
    let longitude: Double
    let category: String
    let categoryImgUrl: String

    var id: Int { placeId }
}

struct PlaceResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [Place]
}
