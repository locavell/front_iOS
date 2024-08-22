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
    @State private var activeSheet: ActiveSheet? = nil // Use an enum to differentiate sheets
    @State private var places: [Place] = []
    @State private var searchText: String = ""
    @State private var centerCoordinate = CLLocationCoordinate2D(latitude: 37.4963538, longitude: 126.9572222) // 숭실대학교
    @State private var selectedCategories: [String] = ["spot", "activity", "food"]
    @State private var recommendedPlaces: [RecommendedPlace] = []

    enum ActiveSheet: Identifiable { // Define an enum for active sheets
        case placesList
        case bottomSheet

        var id: Int {
            hashValue
        }
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            SearchBarView(searchText: $searchText)
            ZStack {
                MapView(places: $places, centerCoordinate: $centerCoordinate, selectedCategories: $selectedCategories)
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
                            activeSheet = .bottomSheet // Set to show BottomSheetView
                        }) {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                        }
                        Spacer()
                        Button(action: {
                            fetchRecommendedPlaces { places in
                                self.recommendedPlaces = places
                                activeSheet = .placesList // Set to show PlacesListView
                            }
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
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
                case .placesList:
                    PlacesListView(places: recommendedPlaces)
                        .presentationDetents([.height(300)])
                case .bottomSheet:
                    BottomSheetView()
                        .presentationDetents([.height(180)])
            }
        }
    }

    private func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
        } else {
            selectedCategories.append(category)
        }
    }
    
    private func fetchRecommendedPlaces(completion: @escaping ([RecommendedPlace]) -> Void) {
        guard let userLocation = locationManager.currentLocation else { return }
        let urlString = "https://api.locavel.site/api/places/recommend-results?latitude=\(userLocation.latitude)&longitude=\(userLocation.longitude)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(RecommendedPlaceResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(apiResponse.result)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
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

struct RecommendedPlaceResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [RecommendedPlace]
}

struct RecommendedPlace: Codable {
    let placeId: Int
    let name: String
    let address: String
    let rating: Double
    let reviewCount: Int
    let reviewImgList: [String]
}
