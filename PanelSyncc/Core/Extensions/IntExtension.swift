//
//  IntExtension.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import Foundation

extension Int {
    /// Converts large integers into abbreviated strings (e.g., 1500 -> "1.5K", 1000000 -> "1M")
    func abbreviated() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            return formatted.truncatingRemainder(dividingBy: 1) == 0 ? "\(sign)\(Int(formatted))B" : "\(sign)\(String(format: "%.1f", formatted))B"
        case 1_000_000...:
            let formatted = num / 1_000_000
            return formatted.truncatingRemainder(dividingBy: 1) == 0 ? "\(sign)\(Int(formatted))M" : "\(sign)\(String(format: "%.1f", formatted))M"
        case 1_000...:
            let formatted = num / 1_000
            return formatted.truncatingRemainder(dividingBy: 1) == 0 ? "\(sign)\(Int(formatted))K" : "\(sign)\(String(format: "%.1f", formatted))K"
        default:
            return "\(self)"
        }
    }
}
