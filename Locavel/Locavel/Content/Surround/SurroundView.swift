//
//  HomeView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

//import SwiftUI
//import MapKit
//
//struct SurroundView: View {
//    @StateObject private var locationManager = LocationManager()
//    @State private var searchText = ""
//    @State private var selectedPlace: IdentifiableMapItem?
//    @State private var showSheet = false
//    @State private var places: [Place] = []
//
//    var body: some View {
//        VStack(alignment: .trailing, spacing: 0) {
//            SearchBarView(searchText: $searchText, onSearch: { query in
//                locationManager.search(for: query) { place in
//                    selectedPlace = place
//                    if let place = place {
//                        locationManager.updateRegion(to: place.mapItem.placemark.coordinate)
//                    }
//                }
//            })
//            ZStack {
//                MapView(region: $locationManager.region, selectedPlace: $selectedPlace, places: $places)
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
//                    Spacer()
//
//                    HStack {
//                        Button(action: {
//                            showSheet.toggle()
//                        }) {
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
//                                .fontWeight(.bold)
//                                .frame(width: 120, height: 35)
//                                .background(Color("AccentColor"))
//                                .foregroundColor(.white)
//                                .cornerRadius(25)
//                                .shadow(radius: 5)
//                        }
//                        Spacer()
//                        Button(action: {
//                            locationManager.showUserLocation()
//                        }) {
//                            Image(systemName: "location.fill")
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(25)
//                                .shadow(radius: 5)
//                        }
//                    }
//                    .padding()
//                }
//            }
//            Spacer()
//        }
//        .sheet(isPresented: $showSheet) {
//            BottomSheetView()
//                .presentationDetents([.height(180)])
//        }
//        .onAppear {
//            locationManager.requestLocationPermission()
//        }
//    }
//}
//
//#Preview {
//    SurroundView()
//}

import SwiftUI
import MapKit

struct SurroundView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showSheet = false
    @State private var places: [Place] = []
    @State private var searchText: String = ""
    @State private var centerCoordinate = CLLocationCoordinate2D(latitude: 37.4963538, longitude: 126.9572222) // 숭실대학교

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            SearchBarView(searchText: $searchText)
            ZStack {
                MapView(places: $places, centerCoordinate: $centerCoordinate)
                    .edgesIgnoringSafeArea(.all)
                    .environmentObject(locationManager)
                
                VStack {
                    Spacer()

                    HStack {
                        Button(action: {
                            showSheet.toggle()
                        }) {
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
                                .fontWeight(.bold)
                                .frame(width: 120, height: 35)
                                .background(Color("AccentColor"))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                        }
                        Spacer()
                        Button(action: {
                            if let userLocation = locationManager.currentLocation {
                                centerCoordinate = userLocation
                            }
                        }) {
                            Image(systemName: "location.fill")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .sheet(isPresented: $showSheet) {
            BottomSheetView()
                .presentationDetents([.height(180)])
        }
    }
}
