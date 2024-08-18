//
//  NMLocationManager.swift
//  Locavel
//
//  Created by 김의정 on 8/19/24.
//

import Foundation
import CoreLocation
import NMapsMap

class NMLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentAddress: String?
    private let naverClientId = "m2oss2y2nd"
    private let naverClientSecret = "Fk31QrTACSOb8nvxNrMvGNPy6Wck2o5pU1uTniLs"
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func fetchCurrentLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            reverseGeocode(location: location)
            locationManager.stopUpdatingLocation()
        }
    }

    private func reverseGeocode(location: CLLocation) {
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        let urlString = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=\(lng),\(lat)&orders=roadaddr,addr&output=json"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(naverClientId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue(naverClientSecret, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let firstResult = results.first,
                   let region = firstResult["region"] as? [String: Any],
                   let area1 = region["area1"] as? [String: Any],
                   let area2 = region["area2"] as? [String: Any],
                   let area3 = region["area3"] as? [String: Any],
                   let name1 = area1["name"] as? String,
                   let name2 = area2["name"] as? String,
                   let name3 = area3["name"] as? String {
                    
                    DispatchQueue.main.async {
                        self.currentAddress = "\(name1) \(name2) \(name3)"
                    }
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
