import Foundation


enum SelectorType: Int, CaseIterable{
    
    case referralReason
    case operation
    
    var title: String{
        switch self {
        case .referralReason: return "Referral Reason"
        case .operation: return "Operation"
        }
    }
    
    var imageName: String{
        switch self {
        case .referralReason: return "info.circle"
        case .operation: return "list.clipboard"
        }
    }
}
