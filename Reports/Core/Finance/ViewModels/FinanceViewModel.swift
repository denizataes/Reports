//
//  FinanceViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation

class FinanceViewModel: ObservableObject{
    // MARK: Coverage
    @Published var coverageFacilityList: [StatisticModel] = []
    @Published var coverageSpecialityList: [StatisticModel] = []
    @Published var coverageDoctorList: [StatisticModel] = []
    @Published var coverageUserList: [StatisticModel] = []
    
    // MARK: Invoice
    @Published var invoiceFacilityList: [StatisticModel] = []
    @Published var invoiceSpecialityList: [StatisticModel] = []
    @Published var invoiceDoctorList: [StatisticModel] = []
    @Published var invoiceUserList: [StatisticModel] = []
    
    // MARK: Selection
    @Published var selectedUnit: ResultModel?
    @Published var selectedDoctor: DetailedDoctor?
    @Published var selectedUser: ResultModel?
    @Published var selectedFacility: ResultModel?
    
    //MARK: Loading Invoice
    @Published var coverageFacilityLoading: Bool = false
    @Published var coverageUserLoading: Bool = false
    @Published var coverageDoctorLoading: Bool = false
    @Published var coverageSpecialityLoading: Bool = false
    
    
    //MARK: Loading Coverage
    @Published var invoiceFacilityLoading: Bool = false
    @Published var invoiceUserLoading: Bool = false
    @Published var invoiceDoctorLoading: Bool = false
    @Published var invoiceSpecialityLoading: Bool = false
    
    let service = ReportsService.shared
    
    init(){
        getCoverageFacility(startDate: Date(), endDate: Date(), facilityID: selectedFacility?.objectID)
        getCoverageUser(startDate: Date(), endDate: Date(), userID: selectedUser?.objectID)
        getCoverageDoctor(startDate: Date(), endDate: Date(), doctorID: selectedDoctor?.objectID)
        getCoverageSpeciality(startDate: Date(), endDate: Date(), unitID: selectedUnit?.objectID)
        
        getInvoiceFacility(startDate: Date(), endDate: Date(), facilityID: selectedFacility?.objectID)
        getInvoiceUser(startDate: Date(), endDate: Date(), userID: selectedUser?.objectID)
        getInvoiceDoctor(startDate: Date(), endDate: Date(), doctorID: selectedDoctor?.objectID)
        getInvoiceSpeciality(startDate: Date(), endDate: Date(), unitID: selectedUnit?.objectID)
        
    }
    
    func search(startDate: Date, endDate: Date){
        clear()
        getCoverageFacility(startDate: startDate, endDate: endDate, facilityID: selectedFacility?.objectID)
        getCoverageUser(startDate: startDate, endDate: endDate, userID: selectedUser?.objectID)
        getCoverageDoctor(startDate: startDate, endDate: endDate, doctorID: selectedDoctor?.objectID)
        getCoverageSpeciality(startDate: startDate, endDate: endDate, unitID: selectedUnit?.objectID)
        
        getInvoiceFacility(startDate: startDate, endDate: endDate, facilityID: selectedFacility?.objectID)
        getInvoiceUser(startDate: startDate, endDate: endDate, userID: selectedUser?.objectID)
        getInvoiceDoctor(startDate: startDate, endDate: endDate, doctorID: selectedDoctor?.objectID)
        getInvoiceSpeciality(startDate: startDate, endDate: endDate, unitID: selectedUnit?.objectID)
        
    }
    
    func clear(){
        coverageUserList.removeAll()
        coverageDoctorList.removeAll()
        coverageFacilityList.removeAll()
        coverageSpecialityList.removeAll()
        
        invoiceUserList.removeAll()
        invoiceDoctorList.removeAll()
        invoiceFacilityList.removeAll()
        invoiceSpecialityList.removeAll()
    }
    
    // MARK: Coverage
    
    func getCoverageFacility(startDate: Date?, endDate: Date?, facilityID: Int?){
        coverageFacilityLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_CoverageFacilityURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "facilityId": facilityID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.coverageFacilityLoading = false
                switch(result){
                case .success(let facilityList):
                    DispatchQueue.main.async{
                        strongSelf.coverageFacilityList = facilityList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    
    func getCoverageSpeciality(startDate: Date?, endDate: Date?, unitID: Int?){
        coverageSpecialityLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_CoverageUnitURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "unitId" : unitID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.coverageSpecialityLoading = false
                switch(result){
                case .success(let specialityList):
                    DispatchQueue.main.async{
                        strongSelf.coverageSpecialityList = specialityList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    
    func getCoverageUser(startDate: Date?, endDate: Date?, userID: Int?){
        coverageUserLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_CoverageUserURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "userId" : userID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.coverageUserLoading = false
                switch(result){
                case .success(let userList):
                    DispatchQueue.main.async{
                        strongSelf.coverageUserList = userList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    func getCoverageDoctor(startDate: Date?, endDate: Date?, doctorID: Int?){
        coverageDoctorLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_CoverageDoctorURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID
            ],
            responseType: [StatisticModel].self) {[weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.coverageDoctorLoading = false
                switch(result){
                case .success(let doctorList):
                    DispatchQueue.main.async{
                        strongSelf.coverageDoctorList = doctorList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    // MARK: Invoice
    
    func getInvoiceSpeciality(startDate: Date?, endDate: Date?, unitID: Int?){
        invoiceSpecialityLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_InvoiceUnitURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "unitId" : unitID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.invoiceSpecialityLoading = false
                switch(result){
                case .success(let specialityList):
                    DispatchQueue.main.async{
                        strongSelf.invoiceSpecialityList = specialityList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    func getInvoiceFacility(startDate: Date?, endDate: Date?, facilityID: Int?){
        invoiceFacilityLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_InvoiceFacilityURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "facilityId" : facilityID
            ],
            responseType: [StatisticModel].self) {[weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.invoiceFacilityLoading = false
                switch(result){
                case .success(let facilityList):
                    DispatchQueue.main.async{
                        strongSelf.invoiceFacilityList = facilityList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    func getInvoiceUser(startDate: Date?, endDate: Date?, userID: Int?){
        invoiceUserLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_InvoiceUserURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "userId" : userID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.invoiceUserLoading = false
                switch(result){
                case .success(let userList):
                    DispatchQueue.main.async{
                        strongSelf.invoiceUserList = userList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    func getInvoiceDoctor(startDate: Date?, endDate: Date?, doctorID: Int?){
        invoiceDoctorLoading = true
        let startDateString = String.formattedDate(date: startDate)
        let endDateString = String.formattedDate(date: endDate)
        
        self.service.makeGetRequest(
            endpoint: Statics.fin_InvoiceDoctorURL,
            parameters: [
                "startDate" : startDateString,
                "endDate" : endDateString,
                "doctorId" : doctorID
            ],
            responseType: [StatisticModel].self) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.invoiceDoctorLoading = false
                switch(result){
                case .success(let doctorList):
                    DispatchQueue.main.async{
                        strongSelf.invoiceDoctorList = doctorList
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    
}

