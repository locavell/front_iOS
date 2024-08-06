//
//  HomeView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//
//
//import SwiftUI
//import NMapsMap
//import CoreLocation
//import MapKit
//
//struct HomeView: View {
//    @State private var searchText: String = ""
//    
//    var body: some View {
//        VStack(alignment: .trailing, spacing: 0) {
//          SearchBarView(searchText: $searchText)
//            NaverMapView().edgesIgnoringSafeArea(.all)
//      }
//  }
//}
//
//struct NaverMapView: View {
//    @StateObject private var locationManager = LocationManager()
//    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
//    @State private var selectedPlace: MKMapItem?
//
//    var body: some View {
//        ZStack {
//            Map(position: $position, selection: $selectedPlace) {
//                UserAnnotation()
//                if let userLocation = locationManager.userLocation {
//                    Marker("Current Location", coordinate: userLocation.coordinate)
//                }
//            }
//            .mapControls {
//                MapUserLocationButton()
//            }
//            .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                Spacer()
//                Button(action: {
//                    if let userLocation = locationManager.userLocation {
//                        withAnimation {
//                            position = .region(MKCoordinateRegion(
//                                center: userLocation.coordinate,
//                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                            ))
//                        }
//                    }
//                }) {
//                    Text("현재 위치로 이동")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 20)
//            }
//        }
//        .onAppear {
//            locationManager.requestLocation()
//        }
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var userLocation: CLLocation?
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    func requestLocation() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        userLocation = location
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//}
//
//#Preview {
//    HomeView()
//}


//import SwiftUI
//import NMapsMap
//import CoreLocation
//import Foundation
//
//
//struct HomeView: View {
//    @State private var searchText: String = ""
//    @StateObject private var locationManager = LocationManager()
//    @State private var mapView = NMFMapView() // Keep a reference to the map view
//    
//    var body: some View {
//        VStack {
//            SearchBarView(searchText: $searchText)
//            ZStack {
//                NaverMapView(currentLocation: $locationManager.currentLocation, mapView: $mapView)
//                VStack {
//                    Spacer()
//                    
//                    HStack {
//                        Button(action: {}) {
//                            Image(systemName: "plus")
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(25)
//                                .shadow(radius: 5)
//                        }
//                        Spacer()
//                        Button(action: {}) {
//                            Text("목록")
//                                .padding()
//                                .background(Color.red)
//                                .foregroundColor(.white)
//                                .cornerRadius(25)
//                                .shadow(radius: 5)
//                        }
//                        .padding(.leading, 10)
//                        Spacer()
//                        Button(action: {
//                            locationManager.requestLocation()
//                            if let location = locationManager.currentLocation {
//                                mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.latitude, lng: location.longitude)))
//                            }
//                        }) {
//                            Image(systemName: "location.fill")
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(25)
//                                .shadow(radius: 5)
//                        }
//                        .padding(.leading, 10)
//                    }
//                    .padding()
//                }
//            }
//            Spacer()
//        }
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var currentLocation: CLLocationCoordinate2D?
//    
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//    
//    func requestLocation() {
//        self.locationManager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        self.currentLocation = location.coordinate
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to get user location: \(error.localizedDescription)")
//    }
//}
//
//struct NaverMapView: UIViewRepresentable {
//    @Binding var currentLocation: CLLocationCoordinate2D?
//    @Binding var mapView: NMFMapView // Pass the map view reference
//    
//    func makeUIView(context: Context) -> NMFMapView {
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: NMFMapView, context: Context) {
//        if let location = currentLocation {
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.latitude, lng: location.longitude))
//            uiView.moveCamera(cameraUpdate)
//            
//        }
//    }
//}
//
//
//#Preview {
//    HomeView()
//}


// 구현 코드 메인
//import SwiftUI
//import UIKit
//import NMapsMap
//import Combine
//
//struct HomeView: View {
//    @State private var searchText: String = ""
//    
//    var body: some View {
//        VStack(alignment: .trailing, spacing: 0) {
//            SearchBarView(searchText: $searchText)
//            MapView()
//        }
//    }
//}
//
//struct MapView: View {
//    @StateObject var coordinator: Coordinator = Coordinator.shared
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                NaverMap()
//                    .ignoresSafeArea(.all, edges: .top)
//            }
//            .onAppear {
//                Coordinator.shared.checkIfLocationServiceIsEnabled()
//            }
//            VStack {
//                Spacer()
//                
//                HStack {
//                    Button(action: {}) {
//                        Image(systemName: "plus")
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(25)
//                            .shadow(radius: 5)
//                    }
//                    Spacer()
//                    Button(action: {}) {
//                        Text("목록")
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(25)
//                            .shadow(radius: 5)
//                    }
//                    .padding(.leading, 10)
//                    Spacer()
//                    Button(action: {
//                        Coordinator.shared.fetchUserLocation()
//                    }) {
//                        Image(systemName: "location.fill")
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(25)
//                            .shadow(radius: 5)
//                    }
//                    .padding(.leading, 10)
//                }
//                .padding()
//            }
//        }
//        Spacer()
//    }
//}
//
//struct NaverMap: UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        Coordinator.shared
//    }
//    
//    func makeUIView(context: Context) -> NMFNaverMapView {
//        context.coordinator.getNaverMapView()
//    }
//    
//    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
//}
//
//final class Coordinator: NSObject, ObservableObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
//    static let shared = Coordinator()
//    
//    let view = NMFNaverMapView(frame: .zero)
//    
//    override init() {
//        super.init()
//        
//        view.mapView.positionMode = .compass
//        view.mapView.isNightModeEnabled = true
//        
//        view.mapView.zoomLevel = 17
//        view.mapView.minZoomLevel = 9
//        view.mapView.maxZoomLevel = 20
//        
//        view.showLocationButton = false // 기본 제공 위치 버튼 숨기기
//        view.showZoomControls = true
//        view.showCompass = true
//        view.showScaleBar = true
//        
//        view.mapView.addCameraDelegate(delegate: self)
//        view.mapView.touchDelegate = self
//    }
//    
//    @Published var coord: (Double, Double) = (0.0, 0.0)
//    @Published var userLocation: (Double, Double) = (0.0, 0.0)
//    
//    var locationManager: CLLocationManager?
//    
//    func checkLocationAuthorization() {
//        guard let locationManager = locationManager else { return }
//        
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted, .denied:
//            print("위치 정보 접근이 제한되었습니다.")
//        case .authorizedAlways, .authorizedWhenInUse:
//            coord = (locationManager.location?.coordinate.latitude ?? 0.0, locationManager.location?.coordinate.longitude ?? 0.0)
//            userLocation = (locationManager.location?.coordinate.latitude ?? 0.0, locationManager.location?.coordinate.longitude ?? 0.0)
//            fetchUserLocation()
//        @unknown default:
//            break
//        }
//    }
//    
//    func checkIfLocationServiceIsEnabled() {
//        DispatchQueue.global().async {
//            if CLLocationManager.locationServicesEnabled() {
//                DispatchQueue.main.async {
//                    self.locationManager = CLLocationManager()
//                    self.locationManager!.delegate = self
//                    self.checkLocationAuthorization()
//                }
//            } else {
//                print("Show an alert letting them know this is off and to go turn i on")
//            }
//        }
//    }
//    
//    func fetchUserLocation() {
//        if let locationManager = locationManager {
//            let lat = locationManager.location?.coordinate.latitude
//            let lng = locationManager.location?.coordinate.longitude
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0), zoomTo: 15)
////            cameraUpdate.animation = .easeIn
////            cameraUpdate.animationDuration = 1
//            
//            let locationOverlay = view.mapView.locationOverlay
//            locationOverlay.location = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
//            locationOverlay.hidden = false
//            
//            locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
//            locationOverlay.iconWidth = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
//            locationOverlay.iconHeight = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
//            locationOverlay.anchor = CGPoint(x: 0.5, y: 1)
//            
//            view.mapView.moveCamera(cameraUpdate)
//        }
//    }
//    
//    func getNaverMapView() -> NMFNaverMapView {
//        view
//    }
//}
//
//#Preview {
//    HomeView()
//}




// 검색기능 여기서 참고하기
//struct HomeView: View {
//    @State private var address = ""
//    @State private var coordinate: NMGLatLng?
//    
//    var body: some View {
//        VStack {
//            TextField("주소 입력", text: $address)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button("검색") {
//                searchAddress()
//            }
//            
//            if let coordinate = coordinate {
//                Text("위도: \(coordinate.lat), 경도: \(coordinate.lng)")
//            }
//            
//            NaverMapView(coordinate: coordinate)
//                .frame(height: 300)
//        }
//    }
//    
//    func searchAddress() {
//        // 네이버 Geocoding API를 사용하여 주소를 좌표로 변환
//        // 실제 구현에서는 네트워크 요청을 통해 좌표를 가져와야 합니다
//        // 여기서는 예시로 고정된 좌표를 사용합니다
//        coordinate = NMGLatLng(lat: 37.5666805, lng: 126.9784147)
//    }
//}
//
//struct NaverMapView: UIViewRepresentable {
//    var coordinate: NMGLatLng?
//    
//    func makeUIView(context: Context) -> NMFNaverMapView {
//        let mapView = NMFNaverMapView()
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
//        if let coordinate = coordinate {
//            let marker = NMFMarker()
//            marker.position = coordinate
//            marker.mapView = uiView.mapView
//            
//            let cameraUpdate = NMFCameraUpdate(scrollTo: coordinate)
//            uiView.mapView.moveCamera(cameraUpdate)
//        }
//    }
//}


import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            SearchBarView(searchText: $searchText)
            MapView()
        }
    }
}

struct MapView: View {
    @StateObject var coordinator: Coordinator = Coordinator.shared
    //    @StateObject var firestoreManager = FireStoreManager()

    var body: some View {
        ZStack {
            VStack {
                NaverMap()
//                NaverMap().setmark(lat: firestoreManager.mylat, lng: firestoreManager.mylng)
                    .ignoresSafeArea(.all, edges: .top)
            }
//            .onAppear {
////                Coordinator.shared.checkIfLocationServiceIsEnabled()
////                Task {
////                    await firestoreManager.fetchData()
////    //                Coordinator.shared.setMarker(lat: firestoreManager.mylat, lng: firestoreManager.mylng)
////                    for item in firestoreManager.myDataModels {
////    //                    print(firestoreManager.myLocation[i].latitude)
////                        Coordinator.shared.setMarker(lat: item.location.latitude, lng: item.location.longitude, name: item.name)
////                    }
////                }
//            }
            VStack {
                Spacer()

                HStack {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("목록")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Button(action: {
                        Coordinator.shared.fetchUserLocation()
                    }) {
                        Image(systemName: "location.fill")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .padding(.leading, 10)
                }
                .padding()
            }
        }
        Spacer()
    }
}

//
#Preview {
    HomeView()
}
