//
//  FinanceViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation

class UnitViewModel: ObservableObject{
    @Published var unitList: [ResultModel] = []
    @Published var loaded: Bool = false
    
    let service = ReportsService.shared
    
    init(){
        getUnits()
    }
    
    func getUnits(){
        self.service.makeGetRequest(
            endpoint: Statics.unitURL,
            parameters: nil,
            responseType: [ResultModel].self) { result in
                switch(result){
                case .success(let unitList):
                    self.loaded = true
                    DispatchQueue.main.async{
                        self.unitList = unitList
                    }
                    break
                case .failure(let error):
                    self.loaded = true
                    print(error )
                    break
                }
            }
    }
    
}

