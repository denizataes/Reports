//
//  FinanceViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation

class SelectorViewModel: ObservableObject{
    @Published var selectorList: [ResultModel] = []
    
    init(selectorType: SelectorType){
        
        if selectorType == .referralReason{
            selectorList.append(.init(objectID: 1, name: "Most Common Reasons"))
            selectorList.append(.init(objectID: 2, name: "Most Common Specialization"))
            selectorList.append(.init(objectID: 3, name: "Most Common Destination"))
        }
        else{
            selectorList.append(.init(objectID: 1, name: "Diagnosis"))
            selectorList.append(.init(objectID: 2, name: "Order"))
            selectorList.append(.init(objectID: 3, name: "Laboratory"))
            selectorList.append(.init(objectID: 4, name: "Radiology"))
        }
    }
    
}

