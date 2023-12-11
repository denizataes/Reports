//
//  FinanceViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation

class UserViewModel: ObservableObject{
    @Published var userList: [ResultModel] = []
    @Published var loaded: Bool = false
    
    let service = ReportsService.shared
    
    init(){
        getUsers()
    }
    
    func getUsers(){
        self.service.makeGetRequest(
            endpoint: Statics.userURL,
            parameters: nil,
            responseType: [ResultModel].self) { result in
                switch(result){
                case .success(let userList):
                    self.loaded = true
                    DispatchQueue.main.async{
                        self.userList = userList
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

