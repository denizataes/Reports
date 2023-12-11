import Foundation


enum FinanceFilterViewModel: Int, CaseIterable{
    
    case invoice
    case coverage
    
    var title: String{
        switch self {
        case .invoice: return "Invoice"
        case .coverage: return "Coverage"
        
        }
    }
}
