import Foundation

struct Capacity: Codable, Identifiable {
    var id = UUID()
    let type: String
    let empty: Int
    let full: Int

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case empty = "Empty"
        case full = "Full"
    }
}
