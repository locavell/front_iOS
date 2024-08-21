//
//  LocationManager.swift
//  Locavel
//
//  Created by 김의정 on 8/12/24.
//

//import Foundation
//import MapKit
//import CoreLocation
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var currentAddress: String?
//    @Published var currentLocation: CLLocationCoordinate2D?
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.4944897, longitude: 126.9597657),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//    
//    private var locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func requestLocationPermission() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            locationManager.startUpdatingLocation()
//        } else {
//            print("Location access denied.")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            updateRegion(to: location.coordinate)
//            reverseGeocode(location: location)
//            locationManager.stopUpdatingLocation()
//        }
//    }
//
//    func showUserLocation() {
//        if let location = locationManager.location {
//            updateRegion(to: location.coordinate)
//        }
//    }
//
//    func updateRegion(to coordinate: CLLocationCoordinate2D) {
//        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//    }
//
//    func search(for query: String, completion: @escaping (IdentifiableMapItem?) -> Void) {
//        guard !query.isEmpty else {
//            completion(nil)
//            return
//        }
//
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = query
//        request.region = region
//
//        MKLocalSearch(request: request).start { response, error in
//            guard let mapItem = response?.mapItems.first else {
//                completion(nil)
//                return
//            }
//            completion(IdentifiableMapItem(mapItem: mapItem))
//        }
//    }
//
//    private func reverseGeocode(location: CLLocation) {
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let placemark = placemarks?.first {
//                let locality = placemark.locality ?? ""
//                let subLocality = placemark.subLocality ?? ""
//                self.currentAddress = "\(locality) \(subLocality)"
//            }
//        }
//    }
//}

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined, .restricted, .denied:
            // Handle other cases
            break
        @unknown default:
            break
        }
    }
}
