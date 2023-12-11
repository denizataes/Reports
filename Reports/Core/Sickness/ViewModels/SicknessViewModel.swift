//
//  FinanceViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation

class SicknessViewModel: ObservableObject{
    @Published var sicknessList: [ResultModel] = []
    @Published var loaded: Bool = false
    
    let service = ReportsService.shared
    
    init(){
        getSicknesses()
    }
    
    func getSicknesses(){
        self.service.makeGetRequest(
            endpoint: Statics.sicknessURL,
            parameters: nil,
            responseType: [ResultModel].self) { result in
                switch(result){
                case .success(let sicknessList):
                    self.loaded = true
                    DispatchQueue.main.async{
                        //self.sicknessList = sicknessList
                        self.sicknessList = Array(sicknessList.prefix(10))
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

