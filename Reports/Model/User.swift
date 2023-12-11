//
//  Doctor.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var objectID: Int
    var name: String
    var username: String
    var email: String
    var tridNo: String
    var personnelID: Int
    var personnelName: String
    var tenantID: Int
    
    enum CodingKeys: String, CodingKey {
        case objectID = "ObjectID"
        case name = "Name"
        case username = "Username"
        case email = "Email"
        case tridNo = "TRIDNo"
        case personnelID = "PersonnelID"
        case personnelName = "PersonnelName"
        case tenantID = "TenantID"
    }
}
