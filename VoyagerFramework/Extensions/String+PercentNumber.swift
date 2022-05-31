//
//  String+Percent.swift
//  VoyagerIOSTest
//
//  Created by James Folk on 5/23/22.
//

import Foundation

extension String {
    var percent: String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 1
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        formatter.positivePrefix = "+"
        
        if let number = NumberFormatter().number(from: self)  {
            return formatter.string(for: number.decimalValue / 100.0) ?? "?"
        }
        return formatter.string(from: 0) ?? "?"
    }
}
