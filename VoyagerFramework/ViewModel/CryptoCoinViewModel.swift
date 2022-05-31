//
//  CryptoCoinViewModel.swift
//  VoyagerIOSTest
//
//  Created by James Folk on 5/23/22.
//

import Foundation
import Combine
//import SwiftUI

class CryptoCoinViewModel: ObservableObject {
    @Published var cryptoCoins: CryptoCoins = []
    @Published var fetching = false
    @Published var searchText = ""
    
    var allData: [CryptoCoin] = []
    
    private var task: AnyCancellable?
}

extension CryptoCoinViewModel {
    
    func getCryptoCoinsPrice(onCompletion: @escaping ()-> Void = {}) -> Error?{
        var myError: Error?
        
        fetching = true
        
        task = CryptoCoinStatistic.get(.price)
            .mapError({ (error) -> Error in
                myError = error
                return error
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.cryptoCoins = []
                    self.fetching = false
                case .finished:
                  print("Combine TimeOut Finish")
                }
              }, receiveValue: { value in
                  self.cryptoCoins = value
                  self.allData = value
                  
                  self.fetching = false

                  onCompletion()
              })
        
        return myError
    }
    
    func search(_ searchText: String, onCompletion: @escaping ()-> Void = {}) {
        task = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !searchText.isEmpty {
                    self.cryptoCoins = self.allData.filter {
                        $0.cryptoSymbol.contains(searchText.uppercased())
                    }
                    onCompletion()
                } else {
                    self.cryptoCoins = self.allData
                    onCompletion()
                }
            })
    }
}
