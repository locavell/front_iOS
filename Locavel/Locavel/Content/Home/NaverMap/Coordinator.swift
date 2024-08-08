//
//  Coordinator.swift
//  Locavel
//
//  Created by 김의정 on 8/4/24.
//

import UIKit
import NMapsMap
import CoreLocation

class Coordinator: NSObject, ObservableObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    static let shared = Coordinator()
    
    @Published var coord: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    
    var locationManager: CLLocationManager?
    let startInfoWindow = NMFInfoWindow()
    
    let view = NMFNaverMapView(frame: .zero)
    
    override init() {
        super.init()
        
        view.mapView.positionMode = .direction
        view.mapView.isNightModeEnabled = true
        
        view.mapView.zoomLevel = 15
        view.mapView.minZoomLevel = 11
        view.mapView.maxZoomLevel = 18
        
        view.showLocationButton = true
        view.showZoomControls = true
        view.showCompass = true
        view.showScaleBar = true
        
        view.mapView.addCameraDelegate(delegate: self)
        view.mapView.touchDelegate = self
        
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location access denied or restricted.")
            // Optionally prompt the user to enable location in settings
        case .authorizedAlways, .authorizedWhenInUse:
            fetchUserLocation()
        @unknown default:
            break
        }
    }
    
    func fetchUserLocation() {
        guard let locationManager = locationManager else { return }
        
        if let location = locationManager.location {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 16)
            
            let locationOverlay = view.mapView.locationOverlay
            locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
            locationOverlay.hidden = false
            locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
            locationOverlay.iconWidth = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
            locationOverlay.iconHeight = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
            locationOverlay.anchor = CGPoint(x: 0.5, y: 1)
            
            view.mapView.moveCamera(cameraUpdate)
        } else {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            fetchUserLocation()
        }
    }
    
    // 기기의 위치가 업데이트될 때마다 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 16)
            
            let locationOverlay = view.mapView.locationOverlay
            locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
            locationOverlay.hidden = false
            locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
            locationOverlay.iconWidth = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
            locationOverlay.iconHeight = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
            locationOverlay.anchor = CGPoint(x: 0.5, y: 1)
            
            view.mapView.moveCamera(cameraUpdate)
        }
    }
    
    // 위치 서비스가 실패할 때 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    func getNaverMapView() -> NMFNaverMapView {
        view
    }
    
    func setMarker(lat: Double, lng: Double, name: String) {
        let marker = NMFMarker()
        marker.iconImage = NMF_MARKER_IMAGE_PINK
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = view.mapView
        
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = name
        infoWindow.dataSource = dataSource
        infoWindow.open(with: marker)
    }

    func moveCamera(lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .fly
        view.mapView.moveCamera(cameraUpdate)
    }
}
