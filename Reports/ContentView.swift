//
//  ContentView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 9.11.2023.
//

import SwiftUI
import Charts
import Alamofire

struct ContentView: View {

    var body: some View {
       Text("")
        
    }
    
    
//    func makeGetRequest() {
//        AF.request("http://192.168.1.67/Sarus.Ent.Reports/Report/Atatest", parameters: ["startDate": formattedStartDate(), "endDate": formattedEndDate()])
//            .responseDecodable(of: [CountryData].self) { response in
//                switch response.result {
//                case .success(let data):
//                    self.countryData = data
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//    }
//    
//
//    
//    func makeGetRequest2() {
//        AF.request("http://192.168.1.67/Sarus.Ent.Reports/Report/AtaTest2", parameters: ["startDate": formattedStartDate(), "endDate": formattedEndDate()])
//            .responseDecodable(of: [StatisticModel].self) { response in
//                switch response.result {
//                case .success(let data):
//                    self.statisticModel = data
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//    }
}

#Preview {
    NavigationView{
        ContentView()
        
    }
    
    
}
