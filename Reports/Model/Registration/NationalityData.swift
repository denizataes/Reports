//
//  CountryData.swift
//  Reports
//
//  Created by Deniz Ata Eş on 9.11.2023.
//

import Foundation

struct NationalityData: Codable, Identifiable {
    var id = UUID()
    let countryName: String
    let total: Int
    let male: Int
    let female: Int
    let unknown: Int
    let other: Int

    enum CodingKeys: String, CodingKey {
        case countryName = "CountryName"
        case total = "Total"
        case male = "Male"
        case female = "Female"
        case unknown = "Unknown"
        case other = "Other"
    }
}
