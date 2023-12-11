//
//  FinanceViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation

class DoctorViewModel: ObservableObject{
    @Published var doctorList: [DetailedDoctor] = []
    @Published var loaded: Bool = false
    
    let service = ReportsService.shared
    
    init(){
        getDoctors()
    }
    
    func getDoctors(){
        self.service.makeGetRequest(
            endpoint: Statics.doctorURL,
            parameters: nil,
            responseType: [DetailedDoctor].self) { result in
                switch(result){
                case .success(let doctorList):
                    self.loaded = true
                    DispatchQueue.main.async{
                        self.doctorList = doctorList
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

