//
//  EnrollLocationView.swift
//  Locavel
//
//  Created by 김의정 on 8/18/24.
//

import SwiftUI
import CoreLocation
import NMapsMap

struct EnrollLocationView: View {
    @State private var enrollLocation: String = ""
    @StateObject private var locationManager = NMLocationManager()
    
    // List of locations
    let locations = [
        "영등포구 여의도동", "영등포구 영등포동", "영등포구 당산동",
        "영등포구 문래동", "영등포구 대림동", "영등포구 양평동",
        "영등포구 도림동", "영등포구 신길1동", "영등포구 신길2동",
        "영등포구 신길3동", "영등포구 신길4동", "영등포구 여의동",
        "동작구 대방동", "동작구 노량진동", "동작구 보라매동",
        "동작구 상도동", "동작구 신대방동"
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar and Current Location Button
                TextField("검색 (ex. 서울시 영등포구)", text: $enrollLocation)
                    .padding(10)
                    .padding(.horizontal)
                
                Button(action: {
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

                // List of locations
                List(locations, id: \.self) { location in
                    Text(location)
                }
                .listStyle(PlainListStyle())
                
                // Display current address
                if let currentAddress = locationManager.currentAddress {
                    Text("현재 주소: \(currentAddress)")
                        .font(.system(size: 15))
                        .padding(.top)
                }

                // Bottom button
                Button(action: {
                    // Action for selecting the location
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
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}
