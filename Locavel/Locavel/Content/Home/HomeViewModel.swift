//
//  HomeViewModel.swift
//  Locavel
//
//  Created by 김의정 on 8/19/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var regionName: String = "Loading..."

    private var cancellable: AnyCancellable?

    func fetchRegionName() {
        guard let url = URL(string: "https://api.locavel.site/api/users/my-area") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")

        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MyAreaResponse.self, decoder: JSONDecoder())
            .map { $0.result.regionName }
            .replaceError(with: "Unknown")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] regionName in
                self?.regionName = regionName
            }
    }
}

struct MyAreaResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: MyAreaResult
}

struct MyAreaResult: Codable {
    let userId: Int
    let regionId: Int
    let regionName: String
}

