//
//  RegistrationViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import Foundation

class AppointmentViewModel: ObservableObject{
    @Published var nationalityList: [NationalityData] = []
    @Published var ageList: [AgeGenderData] = []
    @Published var currentCapacityList: [Capacity] = []
    @Published var historyCapacityList: [Capacity] = []
    
    @Published var historyCapacityDoctor: DetailedDoctor? = nil
    @Published var currentCapacityDoctor: DetailedDoctor? = nil
    
    @Published var historyCapacityUnit: ResultModel? = nil
    @Published var currentCapacityUnit: ResultModel? = nil
    
    @Published var selectedDoctorType: String? = nil
    @Published var selectedUnitType: String? = nil
    
    //MARK: Loading
    @Published var historyLoading: Bool = false
    @Published var currentLoading: Bool = false
    @Published var nationalityLoading: Bool = false
    @Published var ageLoading: Bool = false
    
    let service = ReportsService.shared
    
    init(){
        getNationality(startDate: Date(), endDate: Date())
        getCurrentCapacity(startDate: Date(), endDate: Date(), doctorID: currentCapacityDoctor?.objectID, unitID: currentCapacityUnit?.objectID)
        getPatientAge(startDate: Date(), endDate: Date())
        getHistoryCapacity(startDate: Date(), endDate: Date(), doctorID: historyCapacityDoctor?.objectID, unitID: historyCapacityUnit?.objectID)
    }
    
    func search(startDate: Date, endDate: Date){
        clear()
        getNationality(startDate: startDate, endDate: endDate)
        getPatientAge(startDate: startDate, endDate: endDate)
        getCurrentCapacity(startDate: startDate, endDate: endDate, doctorID: currentCapacityDoctor?.objectID, unitID: currentCapacityUnit?.objectID)
        getHistoryCapacity(startDate: startDate, endDate: endDate, doctorID: historyCapacityDoctor?.objectID, unitID: historyCapacityUnit?.objectID)
    }
    
    func clear(){
        currentCapacityList.removeAll()
        historyCapacityList.removeAll()
        nationalityList.removeAll()
        ageList.removeAll()
    }
    
    func getNationality(startDate: Date?, endDate: Date?){
        nationalityLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
            self.service.makeGetRequest(
            endpoint: Statics.app_NationalityURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString
            ],
            responseType: [NationalityData].self) { [weak self] result in
                guard let strongSelf = self else {return}
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
    
    func getCurrentCapacity(startDate: Date?, endDate: Date?, doctorID: Int?, unitID: Int?){
        currentLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        service.makeGetRequest(
            endpoint: Statics.app_CurrentURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID,
                "unitId" : unitID
            ],
            responseType: [Capacity].self) { [weak self] result in
                guard let strongSelf = self else {return}
                strongSelf.currentLoading = false
            switch(result){
            case .success(let currentCapacityList):
                DispatchQueue.main.async{
                    strongSelf.currentCapacityList = currentCapacityList
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getHistoryCapacity(startDate: Date?, endDate: Date?, doctorID: Int?, unitID: Int?){
        historyLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        service.makeGetRequest(
            endpoint: Statics.app_HistoryURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID,
                "unitId" : unitID
            ],
            responseType: [Capacity].self) { [weak self] result in
                guard let strongSelf = self else {return}
                strongSelf.historyLoading = false
            switch(result){
            case .success(let historyCapacityList):
                DispatchQueue.main.async{
                    strongSelf.historyCapacityList = historyCapacityList
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func getPatientAge(startDate: Date?, endDate: Date?){
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
                guard let strongSelf = self else {return}
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
