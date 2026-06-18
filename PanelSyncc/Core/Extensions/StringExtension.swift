//
//  StringExtension.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import Foundation

extension String {
    /// Converts formatted strings like "1.2M", "45.5K", or "523,109" into an Int
    func toInt() -> Int {
        let cleanString = self.replacingOccurrences(of: ",", with: "").uppercased()
        
        if cleanString.hasSuffix("M") {
            let numberValue = Double(cleanString.dropLast()) ?? 0
            return Int(numberValue * 1_000_000)
        } else if cleanString.hasSuffix("K") {
            let numberValue = Double(cleanString.dropLast()) ?? 0
            return Int(numberValue * 1_000)
        } else {
            return Int(cleanString) ?? 0
        }
    }
}