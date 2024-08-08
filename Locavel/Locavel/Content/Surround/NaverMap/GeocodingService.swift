//
//  GeocodingService.swift
//  Locavel
//
//  Created by 김의정 on 8/5/24.
//

import Foundation

struct GeocodingResponse: Codable {
    let addresses: [Address]
}

struct Address: Codable {
    let roadAddress: String?
    let jibunAddress: String?
    let x: String
    let y: String
}

class GeocodingService {
    private let clientId = "m2oss2y2nd"
    private let clientSecret = "Fk31QrTACSOb8nvxNrMvGNPy6Wck2o5pU1uTniLs"
    
    func geocode(address: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Invalid Address", code: 0, userInfo: nil)))
            return
        }
        
        let urlString = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=\(encodedAddress)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(clientId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue(clientSecret, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let geocodingResponse = try JSONDecoder().decode(GeocodingResponse.self, from: data)
                if let firstAddress = geocodingResponse.addresses.first,
                   let x = Double(firstAddress.x),
                   let y = Double(firstAddress.y) {
                    completion(.success((y, x)))
                } else {
                    completion(.failure(NSError(domain: "No Address Found", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
