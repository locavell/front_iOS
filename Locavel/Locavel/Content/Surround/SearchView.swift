//
//  SearchView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    private let geocodingService = GeocodingService()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.black : Color.blue)
            TextField("어디로 가시나요?", text: $searchText)
                .autocorrectionDisabled(true)
                .foregroundColor(Color.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.primary)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    , alignment: .trailing
                )
                .onSubmit {
                    searchAddress()
                }
        }
        .font(.headline)
        .padding()
    }
    
    func searchAddress() {
        geocodingService.geocode(address: searchText) { result in
            switch result {
            case .success(let coordinates):
                print("Coordinates: \(coordinates)")
                DispatchQueue.main.async {
                    Coordinator.shared.setMarker(lat: coordinates.0, lng: coordinates.1, name: searchText)
                    Coordinator.shared.moveCamera(lat: coordinates.0, lng: coordinates.1)
                }
            case .failure(let error):
                print("Failed to geocode address: \(error.localizedDescription)")
            }
        }
    }
}


struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText = ""

    static var previews: some View {
        SearchBarView(searchText: $searchText)
    }
}
