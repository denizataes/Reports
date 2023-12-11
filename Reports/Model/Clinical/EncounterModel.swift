//
//  Doctor.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import Foundation

struct EncounterModel: Codable, Identifiable {
    var id = UUID()
    var comeType: String?
    var encounter: Int
    var waiting: Int
    
    
    enum CodingKeys: String, CodingKey {
        case comeType = "ComeType"
        case encounter = "Encounter"
        case waiting = "Waiting"
    }
}
