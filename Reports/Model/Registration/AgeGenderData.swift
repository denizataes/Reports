//
//  AgeGenderData.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import Foundation

struct AgeGenderData: Codable, Identifiable {
    var id = UUID()
    var type: String
    var male: Int
    var female: Int
    
    enum CodingKeys: String, CodingKey {
        case male = "Male"
        case female = "Female"
        case type = "Type"
    }

}

