//
//  String+ParseSlash.swift
//  VoyagerIOSTest
//
//  Created by James Folk on 5/23/22.
//

import Foundation

extension String {
    var cryptoSymbol: String {
        let parts = split(separator: "/")

        // Character sets may be inverted to identify all
        // characters that are *not* a member of the set.
        let delimiterSet = CharacterSet.letters.inverted

        let ret: [String] = parts.compactMap { part in
            // Here we grab the first sequence of letters right
            // before the /-sign, and check that it’s non-empty.
            let name = part.components(separatedBy: delimiterSet)[0]
            return name.isEmpty ? "" : name.uppercased()
        }
        if ret.count > 0 {
            return ret[0]
        }
        return ""
    }
}
