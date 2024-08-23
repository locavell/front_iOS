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
    @State private var showRegisterSheet = false
    @State private var showListSheet = false
    @State private var places: [Place] = []
    @State private var searchText: String = ""
    @State private var centerCoordinate = CLLocationCoordinate2D(latitude: 37.4963538, longitude: 126.9572222) // 숭실대학교
    @State private var selectedCategories: [String] = ["spot", "activity", "food"]
    @State private var selectedPlaceId: IdentifiablePlaceId?  // Identifiable로 감싸줌

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            SearchBarView(searchText: $searchText)
            ZStack {
                MapView(places: $places, centerCoordinate: $centerCoordinate, selectedCategories: $selectedCategories, selectedPlaceId: $selectedPlaceId)
                    .edgesIgnoringSafeArea(.all)
                    .environmentObject(locationManager)
                
                VStack {
                    HStack {
                        FilterButton(category: "spot", isSelected: selectedCategories.contains("spot")) {
                            toggleCategory("spot")
                        }
                        FilterButton(category: "activity", isSelected: selectedCategories.contains("activity")) {
                            toggleCategory("activity")
                        }
                        FilterButton(category: "food", isSelected: selectedCategories.contains("food")) {
                            toggleCategory("food")
                        }
                    }
                    .padding(.top, 10)
                    Spacer()

                    HStack {
                        Button(action: {
                            showRegisterSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                        }
                        Spacer()
                        Button(action: {
                            showListSheet.toggle()  // 목록 버튼 클릭 시 sheet 띄우기
                        }) {
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
        .sheet(item: $selectedPlaceId) { placeId in  // selectedPlaceId가 변경될 때마다 시트 표시
            PlaceDetailView(placeId: placeId.id)  // 실제 ID 값은 placeId.id로 접근
                .presentationDetents([.height(120), .large])
                .presentationDragIndicator(.visible)
                .onDisappear {
                    selectedPlaceId = nil
                }
        }
        .sheet(isPresented: $showRegisterSheet) {
            BottomSheetView()
                .presentationDetents([.height(180)])
        }
        .sheet(isPresented: $showListSheet) {
            PlacesListView(latitude: locationManager.currentLocation?.latitude ?? 0.0,
                           longitude: locationManager.currentLocation?.longitude ?? 0.0)
                .presentationDetents([.height(200), .large])
                .presentationDragIndicator(.visible)
        }
    }

    private func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
        } else {
            selectedCategories.append(category)
        }
    }
}


struct FilterButton: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: getIconName(for: category))
                    .foregroundColor(isSelected ? .white : Color("AccentColor"))
                    .fontWeight(.bold)
                Text(getCategoryText(for: category))
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isSelected ? Color("AccentColor") : Color.white)
            .cornerRadius(40)
            .foregroundColor(isSelected ? .white : Color("AccentColor"))
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        }
    }
    
    private func getIconName(for category: String) -> String {
        switch category {
        case "spot":
            return "camera"
        case "activity":
            return "figure.run"
        case "food":
            return "fork.knife"
        default:
            return "questionmark"
        }
    }

    private func getCategoryText(for category: String) -> String {
        switch category {
        case "spot":
            return "스팟"
        case "activity":
            return "액티비티"
        case "food":
            return "푸드"
        default:
            return "기타"
        }
    }
}

struct IdentifiablePlaceId: Identifiable {
    let id: Int
}
