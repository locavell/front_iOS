//
//  EnrollLocationView.swift
//  Locavel
//
//  Created by 김의정 on 8/18/24.
//

import SwiftUI
import CoreLocation

struct EnrollLocationView: View {
    @State private var enrollLocation: String = ""
    @StateObject private var locationManager = NMLocationManager()
    @State private var showLoadingPage = false
    
    // List of locations
    let allLocations = [
        "서울특별시 강남구", "서울특별시 강동구", "서울특별시 강서구", "서울특별시 강북구", "서울특별시 관악구",
        "서울특별시 광진구", "서울특별시 구로구", "서울특별시 금천구", "서울특별시 노원구", "서울특별시 동대문구",
        "서울특별시 도봉구", "서울특별시 동작구", "서울특별시 마포구", "서울특별시 서대문구", "서울특별시 성동구",
        "서울특별시 성북구", "서울특별시 서초구", "서울특별시 송파구", "서울특별시 영등포구", "서울특별시 용산구",
        "서울특별시 양천구", "서울특별시 은평구", "서울특별시 종로구", "서울특별시 중구", "서울특별시 중랑구",
    ]
    
    // Filtered locations based on user input
    var filteredLocations: [String] {
        if enrollLocation.isEmpty {
            return []
        } else {
            return allLocations.filter { $0.contains(enrollLocation) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar and Current Location Button
                TextField("검색 (ex. 서울특별시 강남구)", text: $enrollLocation)
                    .padding(10)
                    .padding(.horizontal)
                    .onChange(of: enrollLocation) { newValue in
                        // This will trigger the view to update the filteredLocations
                    }
                
                Button(action: {
                    locationManager.requestLocationPermission()
                    locationManager.fetchCurrentLocation()
                }) {
                    Text("현재 위치로 찾기")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .frame(width: 250, height: 32)
                        .background(.white)
                        .foregroundColor(Color("AccentColor"))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color("AccentColor"), lineWidth: 0.7)
                        )
                }
                
                HStack {
                    Text("근처 동네")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()

                // List of filtered locations
                if !filteredLocations.isEmpty {
                    List(filteredLocations, id: \.self) { location in
                        Text(location)
                            .onTapGesture {
                                enrollLocation = location
                            }
                    }
                    .listStyle(PlainListStyle())
                }
                
                // Display current address
                if let currentAddress = locationManager.currentAddress {
                    Text("현재 주소: \(currentAddress)")
                        .font(.system(size: 18))
                        .padding(3)
                }

                // Bottom button
                Button(action: {
                    postCurrentLocation()
                    showLoadingPage = true
                }) {
                    Text("선택하기")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color("AccentColor"))
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                .padding(.bottom)
                .fullScreenCover(isPresented: $showLoadingPage) {
                    LoadingPageView()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func postCurrentLocation() {
        guard let location = locationManager.currentLocation else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let urlString = "https://api.locavel.site/api/users/my-area?latitude=\(latitude)&longitude=\(longitude)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization") // addValue랑 차이가 뭐지
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                print("Headers: \(httpResponse.allHeaderFields)")
                
                if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")
                }
            } else {
                print("Failed to cast response to HTTPURLResponse")
            }
//            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                print("Location posted successfully")
//            } else {
//                print("Failed to post location")
//            }
        }.resume()
    }
}
