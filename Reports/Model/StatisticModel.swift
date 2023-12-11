import Foundation

struct StatisticModel: Codable, Identifiable {
    var id = UUID()
    let valueText: String?
    let valueInt: Int
    let valueDec: Decimal?

    enum CodingKeys: String, CodingKey {
        case valueText = "ValueText"
        case valueInt = "ValueInt"
        case valueDec = "ValueDec"
    }
}

extension [StatisticModel]{
    func index(_ on: String) -> Int{
        if let index = self.firstIndex(where: {
            $0.valueText == on
        }) {
            return index
        }
        return 0
    }
}


extension [NationalityData]{
    func index(_ on: String) -> Int{
        if let index = self.firstIndex(where: {
            $0.countryName == on
        }) {
            return index
        }
        return 0
    }
}

extension [AgeGenderData]{
    func index(_ on: String) -> Int{
        if let index = self.firstIndex(where: {
            $0.type == on
        }) {
            return index
        }
        return 0
    }
}

extension [Capacity]{
    func index(_ on: String) -> Int{
        if let index = self.firstIndex(where: {
            $0.type == on
        }) {
            return index
        }
        return 0
    }
}

extension [DoctorModel]{
    func index(_ on: String) -> Int{
        if let index = self.firstIndex(where: {
            $0.doctorName == on
        }) {
            return index
        }
        return 0
    }
}

extension [EncounterModel]{
    func index(_ on: String) -> Int{
        if let index = self.firstIndex(where: {
            $0.comeType == on
        }) {
            return index
        }
        return 0
    }
}



