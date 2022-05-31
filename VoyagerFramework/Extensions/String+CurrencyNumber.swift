//
//  Float+Currency.swift
//  VoyagerIOSTest
//
//  Created by James Folk on 5/23/22.
//

import Foundation

extension String {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        if let number = NumberFormatter().number(from: self) {
            return formatter.string(from: number as NSNumber) ?? "?"
        }
        return formatter.string(from: 0) ?? "?"
    }
}
