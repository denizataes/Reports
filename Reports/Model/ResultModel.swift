//
//  Doctor.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import Foundation

struct ResultModel: Codable, Identifiable {
    var id = UUID()
    var objectID: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case objectID = "ObjectID"
        case name = "Name"
    }
}
