import Foundation

struct DetailedDoctor: Codable, Identifiable {
    
    var id = UUID()
    var objectID: Int
    var name: String
    var gender: String?
    var userID: Int
    var unitName: String?
    var identityNumber: String
    var role: String
    var birthDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case objectID = "ObjectID"
        case name = "Name"
        case gender = "Gender"
        case userID = "UserID"
        case unitName = "UnitName"
        case identityNumber = "IdentityNumber"
        case role = "Role"
        case birthDate = "BirthDate"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        objectID = try container.decode(Int.self, forKey: .objectID)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
        userID = try container.decode(Int.self, forKey: .userID)
        unitName = try container.decodeIfPresent(String.self, forKey: .unitName)
        identityNumber = try container.decode(String.self, forKey: .identityNumber)
        role = try container.decode(String.self, forKey: .role)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .birthDate) {
            birthDate = try parseDate(from: dateString)
        }
    }
    
    private func parseDate(from dateString: String) throws -> Date? {
        let regex = try NSRegularExpression(pattern: "/Date\\((-?\\d+)([+-]\\d{4})?\\)/", options: [])
        let matches = regex.matches(in: dateString, options: [], range: NSRange(location: 0, length: dateString.utf16.count))

        if let match = matches.first {
            let millisecondsRange = match.range(at: 1)
            if let milliseconds = Range(millisecondsRange, in: dateString) {
                if let millisecondsValue = Int64(String(dateString[milliseconds])) {
                    let seconds = millisecondsValue / 1000
                    return Date(timeIntervalSince1970: TimeInterval(seconds))
                }
            }
        }

        return nil
    }
}
