//
//  RegistrationViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import Foundation
import SwiftUI

class RegistrationViewModel: ObservableObject{
    @Published var nationalityList: [NationalityData] = []
    @Published var ageList: [AgeGenderData] = []
    @Published var encounterStatusList: [StatisticModel] = []
    @Published var encounterTypeList: [StatisticModel] = []

    
    //MARK: Loading
    @Published var encounterStatusLoading: Bool = false
    @Published var encounterTypeLoading: Bool = false
    @Published var nationalityLoading: Bool = false
    @Published var ageLoading: Bool = false
    
    
    let service = ReportsService.shared
    
    init(){
            getNationality(startDate: Date(), endDate: Date())
            getEncounterType(startDate: Date(), endDate: Date())
            getPatientAge(startDate: Date(), endDate: Date())
            getEncounterStatus(startDate: Date(), endDate: Date())
    }
    
    func clear(){
        encounterTypeList.removeAll()
        encounterStatusList.removeAll()
        nationalityList.removeAll()
        ageList.removeAll()
    }
    
    func search(startDate: Date, endDate: Date){
        clear()
        getNationality(startDate: startDate, endDate: endDate)
        getPatientAge(startDate: startDate, endDate: endDate)
        getEncounterType(startDate: startDate, endDate: endDate)
        getEncounterStatus(startDate: startDate, endDate: endDate)
    }
    func getNationality(startDate: Date?, endDate: Date?){
        withAnimation {
            nationalityLoading = true
            let startDateString = String.formattedDate(date: startDate)
            let endDateString = String.formattedDate(date: endDate)
            
                self.service.makeGetRequest(
                endpoint: Statics.reg_NationalityURL,
                parameters: [
                    "startDate" : startDateString,
                    "endDate" : endDateString
                ],
                responseType: [NationalityData].self) { [weak self] result in
                    guard let strongSelf = self else{return}
                    strongSelf.nationalityLoading = false
                switch(result){
                case .success(let nationalityList):
                    DispatchQueue.main.async{
                        strongSelf.nationalityList = nationalityList
                    }
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func getEncounterType(startDate: Date?, endDate: Date?){
        withAnimation {
            encounterTypeLoading = true
            let startDateString = String.formattedDate(date: startDate)
            let endDateString = String.formattedDate(date: endDate)
            
            service.makeGetRequest(
                endpoint: Statics.reg_EncounterTypeURL,
                parameters: [
                    "startDate" : startDateString,
                    "endDate" : endDateString
                ],
                responseType: [StatisticModel].self) { [weak self] result in
                    guard let strongSelf = self else{return}
                    strongSelf.encounterTypeLoading = false
                switch(result){
                case .success(let encounterTypeList):
                    DispatchQueue.main.async{
                        strongSelf.encounterTypeList = encounterTypeList
                    }
                    break
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func getEncounterStatus(startDate: Date?, endDate: Date?){
        withAnimation {
            encounterStatusLoading = true
            let startDateString = String.formattedDate(date: startDate)
            let endDateString = String.formattedDate(date: endDate)
            
            service.makeGetRequest(
                endpoint: Statics.reg_EncounterStatusURL,
                parameters: [
                    "startDate" : startDateString,
                    "endDate" : endDateString
                ],
                responseType: [StatisticModel].self) { [weak self] result in
                    guard let strongSelf = self else{return}
                    strongSelf.encounterStatusLoading = false
                switch(result){
                case .success(let encounterStatusList):
                    DispatchQueue.main.async{
                        strongSelf.encounterStatusList = encounterStatusList
                    }
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func getPatientAge(startDate: Date?, endDate: Date?){
        withAnimation {
            ageLoading = true
            let startDateString = String.formattedDate(date: startDate)
            let endDateString = String.formattedDate(date: endDate)
            
            service.makeGetRequest(
                endpoint: Statics.reg_AgeURL,
                parameters: [
                    "startDate" : startDateString,
                    "endDate" : endDateString
                ],
                responseType: [AgeGenderData].self) { [weak self] result in
                    guard let strongSelf = self else{return}
                    strongSelf.ageLoading = false
                switch(result){
                case .success(let ageGenderList):
                    DispatchQueue.main.async{
                        strongSelf.ageList = ageGenderList
                    }
                    break
                case .failure(_):
                    break
                }
            }
        }

    }
}
