//
//  MainTabView.swift
//  TwitterSwiftUI
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct MainTabView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var isShowingActionSheet = false
    @State private var selectedOption: String? = nil
    
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var appointmentViewModel = AppointmentViewModel()
    @StateObject private var clinicalViewModel = ClinicalViewModel()
    @StateObject private var financeViewModel = FinanceViewModel()
    @EnvironmentObject private  var ipViewModel: IPViewModel
    @EnvironmentObject private  var loginViewModel: LoginViewModel
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack{
                Menu {
                    Button {
                        Haptics.shared.play(.soft)
                        ipViewModel.userEnteredURL = ""
                        Statics.baseURL = ""
                        ipViewModel.isMainScreenVisible = false
                        clearAll()
                        
                    } label: {
                        Label("Edit IP", systemImage: "network.badge.shield.half.filled")
                    }
                    
                    Section {
                        Button(role: .destructive) {
                            withAnimation {
                                Haptics.shared.play(.soft)
                                loginViewModel.currentUser = nil
                                ipViewModel.userEnteredURL = ""
                                Statics.baseURL = ""
                                ipViewModel.isMainScreenVisible = false
                                clearAll()
                            }
                        } label: {
                            Label("Log out", systemImage: "power")
                                .bold()
                                .foregroundStyle(.red)
                        }
                    }
                    
                    
                    
                } label: {
                    Image(systemName: "gear")
                        .foregroundStyle(Color(hex: "A29475"))
                }
                
                Spacer()
                
                VStack(alignment: .trailing){
                    
                    Text(loginViewModel.currentUser?.name ?? "")
                        .font(.caption)
                        .bold()
                    HStack{
                        Text(Statics.baseURL)
                            .font(.caption)
                            .bold()
                        
                        Image(systemName: !ipViewModel.isMultiplyVisible ? "checkmark.circle" : "multiply.circle")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(!ipViewModel.isMultiplyVisible ? .green : .red)
                    }
                    Text("Version 1.0")
                        .font(.caption2)
                        .opacity(0.5)
                    
                }
                .foregroundStyle(Color(hex: "A29475"))
                
            }
            .padding(.horizontal)
            
            HStack {
                
                VStack(spacing: 4) {
                    Text("Start Time")
                        .bold()
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "8A1538"))
                        .foregroundStyle(.white)
                    
                    DatePicker("Başlangıç Zamanı", selection: $startDate, displayedComponents: .date)
                        .labelsHidden()
                        .accentColor(Color(hex: "8A1538"))
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("End Time")
                        .bold()
                        .foregroundStyle(Color(hex: "8A1538"))
                        .font(.system(size: 14))
                    
                    DatePicker("Bitiş Zamanı", selection: $endDate, displayedComponents: .date)
                        .labelsHidden()
                        .accentColor(Color(hex: "8A1538"))
                }
                
                Spacer()
                
                Button("Search") {
                    Haptics.shared.play(.medium)
                    searchRegistration()
                    searchAppointment()
                    searchClinical()
                    searchFinance()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background((Color(hex: "8A1538")))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.top)
            }
            .disableWithOpacity(ipViewModel.isMultiplyVisible)
            .padding(.horizontal)
            .padding(.top, 20) // Adjusted top padding value
            .padding(.bottom, 10) // Adjusted bottom padding value
            //.background(.ultraThinMaterial.opacity(0.1))
            .shadow(radius: 1)
            
            
            TabView {
                NavigationStack{
                    RegistrationView(viewModel: registrationViewModel)
                    
                }
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Registration")
                }
                .refreshable {
                    searchRegistration()
                }
                
                
                NavigationStack{
                    AppointmentView(viewModel: appointmentViewModel) { _ in
                        appointmentViewModel.historyCapacityList.removeAll()
                        appointmentViewModel.getHistoryCapacity(startDate: startDate, endDate: endDate, doctorID: appointmentViewModel.historyCapacityDoctor?.objectID, unitID: appointmentViewModel.historyCapacityUnit?.objectID)
                    } onChangeCurrent: { _ in
                        appointmentViewModel.currentCapacityList.removeAll()
                        appointmentViewModel.getCurrentCapacity(startDate: startDate, endDate: endDate, doctorID: appointmentViewModel.currentCapacityDoctor?.objectID, unitID: appointmentViewModel.currentCapacityUnit?.objectID)
                    }
                    
                    
                }
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text("Appointment")
                }
                .refreshable {
                    searchAppointment()
                }
                
                
                NavigationStack{
                    ClinicalView(viewModel: clinicalViewModel) { _ in
                        clinicalViewModel.doctorDurationList.removeAll()
                        clinicalViewModel.getDoctorDuration(startDate: startDate, endDate: endDate, doctorID: clinicalViewModel.doctorDurationDoctor?.objectID, unitID: clinicalViewModel.doctorDurationUnit?.objectID)
                    } onChangeReferralReason: { _ in
                        clinicalViewModel.referralList.removeAll()
                        clinicalViewModel.getReferral(startDate: startDate, endDate: endDate, doctorID: clinicalViewModel.referralReasonDoctor?.objectID, unitID: clinicalViewModel.referralReasonUnit?.objectID, type: clinicalViewModel.referralReasonType?.objectID)
                    } onChangeSickness: { _ in
                        clinicalViewModel.sicknessList.removeAll()
                        clinicalViewModel.getSicknesses(startDate: startDate, endDate: endDate, sicknessID: clinicalViewModel.selectedSickness?.objectID)
                    } onChangeOperation: { _ in
                        clinicalViewModel.operationList.removeAll()
                        clinicalViewModel.getOperations(startDate: startDate, endDate: endDate, doctorID: clinicalViewModel.operationDoctor?.objectID, unitID: clinicalViewModel.operationUnit?.objectID, type: clinicalViewModel.operationType?.objectID)
                    } onChangeEncounterDuration: { _ in
                        clinicalViewModel.encounterDurationList.removeAll()
                        clinicalViewModel.getEncounterDuration(startDate: startDate, endDate: endDate, doctorID: clinicalViewModel.encounterDurationDoctor?.objectID, unitID: clinicalViewModel.encounterDurationUnit?.objectID)
                    }
                    
                }
                .tabItem {
                    Image(systemName: "stethoscope.circle")
                    Text("Clinical")
                }
                .refreshable {
                    searchClinical()
                }
                
                
                
                NavigationStack{
                    FinanceView(viewModel: financeViewModel) { _ in
                        financeViewModel.invoiceDoctorList.removeAll()
                        financeViewModel.coverageDoctorList.removeAll()
                        financeViewModel.getInvoiceDoctor(startDate: startDate, endDate: endDate, doctorID: financeViewModel.selectedDoctor?.objectID)
                        financeViewModel.getCoverageDoctor(startDate: startDate, endDate: endDate, doctorID: financeViewModel.selectedDoctor?.objectID)
                        
                    } onChangeUnit: { _ in
                        financeViewModel.invoiceSpecialityList.removeAll()
                        financeViewModel.coverageSpecialityList.removeAll()
                        financeViewModel.getInvoiceSpeciality(startDate: startDate, endDate: endDate, unitID: financeViewModel.selectedUnit?.objectID)
                        financeViewModel.getCoverageSpeciality(startDate: startDate, endDate: endDate, unitID: financeViewModel.selectedUnit?.objectID)
                        
                    } onChangeUser: { _ in
                        financeViewModel.invoiceUserList.removeAll()
                        financeViewModel.coverageUserList.removeAll()
                        financeViewModel.getInvoiceUser(startDate: startDate, endDate: endDate, userID: financeViewModel.selectedUser?.objectID)
                        financeViewModel.getCoverageUser(startDate: startDate, endDate: endDate, userID: financeViewModel.selectedUser?.objectID)
                    }
                    
                    
                }
                .refreshable {
                    searchFinance()
                }
                .tabItem {
                    
                    Image(systemName: "dollarsign.circle")
                    Text("Finance")
                    
                    
                }
            }
            .disableWithOpacity(ipViewModel.isMultiplyVisible)
            .accentColor(Color(hex: "009C80"))
            .navigationBarHidden(true)
            .onAppear {
                
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                    if loginViewModel.currentUser != nil{
                        ipViewModel.checkIP()
                    }
                }
            }
            
        }
        
    }
    
    func clearAll(){
        clearRegistration()
        clearAppointment()
        clearClinical()
        clearFinance()
    }
    
    func clearRegistration(){
        registrationViewModel.clear()
    }
    
    func clearAppointment(){
        appointmentViewModel.clear()
    }
    
    func clearClinical(){
        clinicalViewModel.clear()
    }
    
    func clearFinance(){
        financeViewModel.clear()
    }
    
    func searchFinance(){
        financeViewModel.search(startDate: startDate, endDate: endDate)
    }
    
    func searchRegistration(){
        registrationViewModel.search(startDate: startDate, endDate: endDate)
    }
    
    func searchAppointment(){
        appointmentViewModel.search(startDate: startDate, endDate: endDate)
    }
    
    func searchClinical(){
        clinicalViewModel.search(startDate: startDate, endDate: endDate)
    }
    
    
    
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
