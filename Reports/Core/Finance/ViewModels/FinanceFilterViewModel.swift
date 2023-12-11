import Foundation


enum FinanceFilterViewModel: Int, CaseIterable{
    
    case coverage
    case invoice
    
    var title: String{
        switch self {
        case .coverage: return "Coverage"
        case .invoice: return "Invoice"
        }
    }
}
