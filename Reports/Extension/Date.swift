//
//  Date.swift
//  Reports
//
//  Created by Deniz Ata Eş on 20.11.2023.
//

import Foundation

extension Date {
    func age() -> Int {
        let calendar = Calendar.current
        let now = Date()
        
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        let age = ageComponents.year ?? 0
        
        return age
    }
}


