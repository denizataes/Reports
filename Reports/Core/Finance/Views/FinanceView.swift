//
//  FinanceView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import SwiftUI
import Charts

struct FinanceView: View {
    
    //MARK: Properties
    @StateObject var viewModel: FinanceViewModel
    @State private var selectedFilter: FinanceFilterViewModel  = .coverage
    @Namespace var animation
    
    // MARK: Sheets
    @State private var isDoctorSheetPresented = false
    @State private var isUnitSheetPresented = false
    @State private var isUserSheetPresented = false
    
    // MARK: Closures
    var onChangeDoctor: (()) -> Void
    var onChangeUnit: (()) -> Void
    var onChangeUser: (()) -> Void
    
    //MARK: FilterView
    var filterView: some View{
        HStack{
            ForEach(FinanceFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.headline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .primary : .gray)
                    
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(hex: "8A1538"))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
    }
    
    //MARK: InvoiceFacility
    var invoiceFacility: some View{
        VStack{
            HeaderView(header: "Invoice Type by Facility")
            
            if(viewModel.invoiceFacilityList.count > 0 && viewModel.invoiceFacilityList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.invoiceFacilityList) { item in
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .cornerRadius(5)
                            .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))
                        }
                        
                    }
                    .padding()
                    .chartLegend(.hidden)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.invoiceFacilityList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
            }
            
        }
        .overlay(content: {
            if viewModel.invoiceFacilityLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: InvoiceSpeciality
    var invoiceSpeciality: some View{
        VStack{
            HeaderView(header: "Invoice Type by Speciality")
            
            if(viewModel.invoiceSpecialityList.count > 0 && viewModel.invoiceSpecialityList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.invoiceSpecialityList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))
                        }
                        
                    }
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.invoiceSpecialityList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.invoiceSpecialityLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: InvoiceUser
    var invoiceUser: some View{
        VStack{
            HeaderView(header: "Invoice Type by User")
            
            if(viewModel.invoiceUserList.count > 0 && viewModel.invoiceUserList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.invoiceUserList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))

                        }
                        
                    }
                    
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.invoiceUserList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
                
            }
            else{
                NoRecordView()
                
            }
        }
        .overlay(content: {
            if viewModel.invoiceUserLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: InvoiceDoctor
    var invoiceDoctor: some View{
        VStack{
            HeaderView(header: "Billing Information By Doctor")
            
            if(viewModel.invoiceDoctorList.count > 0 && viewModel.invoiceDoctorList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.invoiceDoctorList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))
                            
                            //                                    .annotation(position: .overlay) {
                            //
                            //                                        VStack(spacing: 0){
                            //                                            Text(item.valueText ?? "")
                            //                                                .font(.system(size: 8))
                            //
                            //                                            Text(item.valueDec?.description ?? "")
                            //                                                .font(.system(size: 10))
                            //                                                .bold()
                            //                                        }.foregroundStyle(.white)
                            //                                    }
                        }
                        
                    }
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.invoiceDoctorList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Ödenmemiş Fatura" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.invoiceDoctorLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: CoverageFacility
    var coverageFacility: some View{
        VStack{
            HeaderView(header: "Coverage Types by Facility")
            
            if(viewModel.coverageFacilityList.count > 0 && viewModel.coverageFacilityList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.coverageFacilityList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))
                        }
                        
                    }
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.coverageFacilityList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
                
            }
        }
        .overlay(content: {
            if viewModel.coverageFacilityLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: CoverageSpeciality
    var coverageSpeciality: some View{
        VStack{
            HeaderView(header: "Coverage Types by Speciality")
            
            if(viewModel.coverageSpecialityList.count > 0 && viewModel.coverageSpecialityList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.coverageSpecialityList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))
                        }
                        
                    }
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.coverageSpecialityList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.coverageSpecialityLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: CoverageUser
    var coverageUser: some View{
        VStack{
            HeaderView(header: "Coverage Types by User")
            
            if(viewModel.coverageUserList.count > 0 && viewModel.coverageUserList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.coverageUserList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))

                        }
                        
                    }
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.coverageUserList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.coverageUserLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: CoverageDoctor
    var coverageDoctor: some View{
        VStack{
            Text("Coverage Types by Physician".uppercased())
                .padding(.bottom, 10)
                .font(.system(size: 13))
                .bold()
            
            if(viewModel.coverageDoctorList.count > 0 && viewModel.coverageDoctorList.contains(where: { $0.valueDec ?? 0.0 > 0.0 })) {
                HStack{
                    Chart{
                        ForEach(viewModel.coverageDoctorList) { item in
                            
                            SectorMark(
                                angle: .value("OutstandingValue", item.valueDec ?? 0.0),
                                angularInset: 3.0
                                
                            )
                            .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                            .foregroundStyle(by: .value("ValueText", item.valueText ?? ""))
                            
                            //                                    .annotation(position: .overlay) {
                            //
                            //                                        VStack(spacing: 0){
                            //                                            Text(item.valueText ?? "")
                            //                                                .font(.system(size: 8))
                            //
                            //                                            Text(item.valueDec?.description ?? "")
                            //                                                .font(.system(size: 10))
                            //                                                .bold()
                            //                                        }.foregroundStyle(.white)
                            //                                    }
                        }
                        
                    }
                    .chartLegend(.hidden)
                    .padding()
                    .cornerRadius(10)
                    .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(viewModel.coverageDoctorList) { item in
                            HStack(spacing: 4){
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(item.valueText == "Insurance" ?  Color(hex: "0D4261") : Color(hex: "009C80"))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.valueText ?? "")
                                        .font(.caption2)
                                    Text(item.valueDec?.description  ?? "")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                        
                    }
                }
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.coverageDoctorLoading {
                CustomLoadingView(imageName: "dollarsign.circle", imageColor: "009C80")
            }
        
        })
    }
    
    //MARK: Main
    var body: some View {
        VStack{
            
            filterView
            
            ScrollView(showsIndicators: false){
                
                if(selectedFilter == .invoice){
                    VStack {
                        invoiceFacility
                        
                        invoiceSpeciality
                        
                        invoiceUser

                        invoiceDoctor
                    }
                }
                else{
                    VStack{

                        coverageFacility
                        
                        coverageSpeciality
                        
                        coverageUser
                        
                        coverageDoctor
                        
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Finance")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.selectedUnit != nil ||
                    viewModel.selectedUser != nil ||
                    viewModel.selectedDoctor != nil{
                    
                    Button {
                        Haptics.shared.play(.soft)
                        withAnimation {
                            viewModel.selectedUnit = nil
                            viewModel.selectedDoctor = nil
                            viewModel.selectedUser = nil
                            onChangeUnit(())
                            onChangeDoctor(())
                            onChangeUser(())
                        }
                    } label: {
                        HStack(spacing: 2){
                            Image(systemName: "multiply")
                            Text("Clear")
                        }
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
                    }
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Button {
                        isDoctorSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        
                        VStack{
                            //                            Image(systemName: "stethoscope")
                            //                                .resizable()
                            //                                .frame(width: 20, height: 16)
                            Text(viewModel.selectedDoctor == nil ? "Doctor" : viewModel.selectedDoctor?.name ?? "")
                                .font(.system(size: viewModel.selectedDoctor == nil ? 10 : 12))
                            
                        }
                        .foregroundColor(viewModel.selectedDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.selectedDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                        
                        
                        
                    }
                    
                    Button {
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            //                            Image(systemName: "list.clipboard")
                            //                                .frame(width: 20, height: 16)
                            
                            Text(viewModel.selectedUnit == nil ? "Specialty" : viewModel.selectedUnit?.name ?? "")
                                .font(.system(size: viewModel.selectedUnit == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.selectedUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(5)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.selectedUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    
                    Button {
                        isUserSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            //                            Image(systemName: "person.circle")
                            //                                .frame(width: 20, height: 16)
                            
                            Text(viewModel.selectedUser == nil ? "User" : viewModel.selectedUser?.name ?? "")
                                .font(.system(size: viewModel.selectedUser == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.selectedUser == nil ? .gray : Color(hex: "4194B3"))
                        .bold()
                        .padding(5)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.selectedUser == nil ? Color.gray : Color(hex: "4194B3"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                }
            }
        }
        .sheet(isPresented: $isUnitSheetPresented) {
            UnitListView(onUnitSelection: { selectedUnit in
                withAnimation {
                    viewModel.selectedUnit = selectedUnit
                    onChangeUnit(())
                }
            })
            .presentationDetents([.large, .medium])
        }
        .sheet(isPresented: $isDoctorSheetPresented) {
            DoctorListView(onDoctorSelection: { doctor in
                withAnimation {
                    viewModel.selectedDoctor = doctor
                    onChangeDoctor(())
                }
            })
            .presentationDetents([.large, .medium])
        }
        .sheet(isPresented: $isUserSheetPresented) {
            UserListView(onUserSelection: { selectedUser in
                withAnimation {
                    viewModel.selectedUser = selectedUser
                    onChangeUser(())
                }
            })
            .presentationDetents([.large, .medium])
        }
        
    }
    
}

#Preview {
    FinanceView(viewModel: FinanceViewModel()) { _ in
        print("değişti")
    } onChangeUnit: { _ in
        print("değişti")
    } onChangeUser: { _ in
        print("değişti")
    }
    
}
