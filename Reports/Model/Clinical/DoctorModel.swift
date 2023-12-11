//
//  Doctor.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import Foundation

struct DoctorModel: Codable, Identifiable {
    var id = UUID()
    var doctorName: String
    var encounter: Int
    var waiting: Int
    
    
    enum CodingKeys: String, CodingKey {
        case doctorName = "DoctorName"
        case encounter = "Encounter"
        case waiting = "Waiting"
    }
}
