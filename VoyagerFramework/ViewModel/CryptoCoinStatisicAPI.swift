//
//  CryptoCoinStatisicAPI.swift
//  VoyagerIOSTest
//
//  Created by James Folk on 5/23/22.
//

import Foundation
import Combine

enum CryptoCoinStatistic {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.investvoyager.com/api/pe/v1")!
}

enum APIPath: String {
    case price = "price"
}

extension CryptoCoinStatistic {
    
    static func get(_ path: APIPath) -> AnyPublisher<CryptoCoins, Error> {
        let request = URLRequest(url: baseUrl.appendingPathComponent(path.rawValue))
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

