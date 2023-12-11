//
//  RegistrationViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import Foundation

class ClinicalViewModel: ObservableObject{
    @Published var doctorDurationList: [DoctorModel] = []
    @Published var referralList: [StatisticModel] = []
    @Published var operationList: [StatisticModel] = []
    @Published var sicknessList: [StatisticModel] = []
    @Published var encounterDurationList: [EncounterModel] = []
    
    //MARK: Loading
    @Published var doctorDurationLoading: Bool = false
    @Published var refferalLoading: Bool = false
    @Published var operationLoading: Bool = false
    @Published var sicknessLoading: Bool = false
    @Published var encounterLoading: Bool = false
    
    
    
    // MARK: DoctorDuration
    @Published var doctorDurationDoctor: DetailedDoctor? = nil
    @Published var doctorDurationUnit: ResultModel? = nil
    
    //MARK: ReferralReason
    @Published var referralReasonDoctor: DetailedDoctor? = nil
    @Published var referralReasonUnit: ResultModel? = nil
    @Published var referralReasonType: ResultModel? = nil
    
    
    //MARK: Operation
    @Published var operationDoctor: DetailedDoctor? = nil
    @Published var operationUnit: ResultModel? = nil
    @Published var operationType: ResultModel? = nil
    
    //MARK: EncounterDuraton
    @Published var encounterDurationDoctor: DetailedDoctor? = nil
    @Published var encounterDurationUnit: ResultModel? = nil
    
    //MARK: Sickness
    @Published var selectedSickness: ResultModel? = nil
    
    
    @Published var selectedDoctorType: String? = nil
    @Published var selectedUnitType: String? = nil
    
    
    
    
    let service = ReportsService.shared
    
    init(){
        getDoctorDuration(startDate: Date(), endDate: Date(), doctorID: doctorDurationDoctor?.objectID, unitID: doctorDurationUnit?.objectID)
        getReferral(startDate: Date(), endDate: Date(), doctorID: referralReasonDoctor?.objectID, unitID: referralReasonUnit?.objectID,type: referralReasonType?.objectID)
        getOperations(startDate: Date(), endDate: Date(), doctorID: operationDoctor?.objectID, unitID: operationUnit?.objectID, type: operationType?.objectID)
        getSicknesses(startDate: Date(), endDate: Date(), sicknessID: selectedSickness?.objectID)
        getEncounterDuration(startDate: Date(), endDate: Date(),doctorID: encounterDurationDoctor?.objectID, unitID: encounterDurationUnit?.objectID)
    }
    func search(startDate: Date, endDate: Date){
        clear()
        getDoctorDuration(startDate: startDate, endDate: endDate, doctorID: doctorDurationDoctor?.objectID, unitID: doctorDurationUnit?.objectID)
        getReferral(startDate: startDate, endDate: endDate, doctorID: referralReasonDoctor?.objectID, unitID: referralReasonUnit?.objectID, type: referralReasonType?.objectID)
        getOperations(startDate: startDate, endDate: endDate, doctorID: operationDoctor?.objectID, unitID: operationUnit?.objectID, type: operationType?.objectID)
        getSicknesses(startDate: startDate, endDate: endDate, sicknessID: selectedSickness?.objectID)
        getEncounterDuration(startDate: startDate, endDate: endDate,doctorID: encounterDurationDoctor?.objectID, unitID: encounterDurationUnit?.objectID)
        
    }
    func clear(){
        
        doctorDurationList.removeAll()
        referralList.removeAll()
        operationList.removeAll()
        sicknessList.removeAll()
        encounterDurationList.removeAll()
    }
    
    func getDoctorDuration(startDate: Date?, endDate: Date?, doctorID: Int?, unitID: Int?){
        doctorDurationLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
            self.service.makeGetRequest(
            endpoint: Statics.clinic_DoctorURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID,
                "unitId" : unitID
            ],
            responseType: [DoctorModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.doctorDurationLoading = false
            switch(result){
            case .success(let doctorDurationList):
                DispatchQueue.main.async{
                    strongSelf.doctorDurationList = doctorDurationList
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func getReferral(startDate: Date?, endDate: Date?, doctorID: Int?, unitID: Int?, type: Int?){
        refferalLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        service.makeGetRequest(
            endpoint: Statics.clinic_ReferralURL,
            parameters: [
                "type" : type,
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID,
                "unitId" : unitID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.refferalLoading  = false
            switch(result){
            case .success(let referralList):
                DispatchQueue.main.async{
                    strongSelf.referralList = referralList
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOperations(startDate: Date?, endDate: Date?, doctorID: Int?, unitID: Int?, type: Int?){
        operationLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        service.makeGetRequest(
            endpoint: Statics.clinic_OperationURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID,
                "unitId" : unitID,
                "opType" : type
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.operationLoading = false
            switch(result){
            case .success(let operationList):
                DispatchQueue.main.async{
                    strongSelf.operationList = operationList
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    
    func getSicknesses(startDate: Date?, endDate: Date?, sicknessID: Int?){
        sicknessLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        service.makeGetRequest(
            endpoint: Statics.clinic_SicknessURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "sicknessID": sicknessID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.sicknessLoading = false
            switch(result){
            case .success(let sicknessList):
                DispatchQueue.main.async{
                    strongSelf.sicknessList = sicknessList
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func getEncounterDuration(startDate: Date?, endDate: Date?, doctorID: Int?, unitID: Int?){
        encounterLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        service.makeGetRequest(
            endpoint: Statics.clinic_EncounterURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID,
                "unitId" : unitID
            ],
            responseType: [EncounterModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.encounterLoading = false
                
            switch(result){
            case .success(let encounterDurationList):
                DispatchQueue.main.async{
                    strongSelf.encounterDurationList = encounterDurationList
                }
                break
            case .failure(_):
                break
            }
        }
    }
}
