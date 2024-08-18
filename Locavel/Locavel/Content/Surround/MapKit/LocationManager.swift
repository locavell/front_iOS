//
//  LocationManager.swift
//  Locavel
//
//  Created by 김의정 on 8/12/24.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentAddress: String? // 홈뷰에서 사용자 위치 가져오기 위해 추가
    @Published var currentLocation: CLLocationCoordinate2D? // 홈뷰에서 사용자 위치 가져오기 위해 추가
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.4944897, longitude: 126.9597657),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private var locationManager = CLLocationManager()
    var onRegionUpdate: ((MKCoordinateRegion) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // 홈뷰에서 사용자 위치 가져오기 위해 추가
    func fetchCurrentLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied.")
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 홈뷰에서 사용자 위치 가져오기 위해 추가
        if let location = locations.first {
            currentLocation = location.coordinate
            reverseGeocode(location: location)
            locationManager.stopUpdatingLocation()
        }
        
        guard let location = locations.last else { return }
        updateRegion(to: location.coordinate)
    }

    func showUserLocation() {
        if let location = locationManager.location {
            updateRegion(to: location.coordinate)
        }
    }

    func updateRegion(to coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let newRegion = MKCoordinateRegion(center: coordinate, span: span)
        region = newRegion
    }

    func search(for query: String, completion: @escaping (IdentifiableMapItem?) -> Void) {
        guard !query.isEmpty else {
            completion(nil)
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let mapItem = response?.mapItems.first else {
                completion(nil)
                return
            }
            let identifiableMapItem = IdentifiableMapItem(mapItem: mapItem)
            completion(identifiableMapItem)
        }
    }
    
    // 홈뷰에서 사용자 위치 가져오기 위해 추가
    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                return
            }
            guard let placemark = placemarks?.first else {return}
            
            let locality = placemark.locality ?? ""
            let subLocality = placemark.subLocality ?? ""
            self.currentAddress = "\(locality) \(subLocality)"
        }
    }
}
