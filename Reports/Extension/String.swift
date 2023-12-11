//
//  Extension.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import Foundation
import SwiftUI

extension String {
    static func formattedDate(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            // If the date is nil, use the current date
            return dateFormatter.string(from: Date())
        }
    }
    
    func isIPAddress() -> Bool {
        withAnimation {
            // String'in içindeki sayı ve nokta sayısını kontrol etmek için bir yardımcı fonksiyon
            func countOfCharacter(_ character: Character) -> Int {
                return self.reduce(0) { $0 + ($1 == character ? 1 : 0) }
            }

            // String'in içindeki nokta sayısını ve her bölümün sayısal olup olmadığını kontrol et
            let components = self.split(separator: ".")
            if components.count == 4 && components.allSatisfy({ $0.isNumeric() }) && !self.contains("..") && !self.hasPrefix(".") && !self.hasSuffix(".") {
                return true
            } else {
                return false
            }
        }
    }
}

// Yardımcı bir extension, bir String'in sayısal olup olmadığını kontrol eder
extension Substring {
    func isNumeric() -> Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
