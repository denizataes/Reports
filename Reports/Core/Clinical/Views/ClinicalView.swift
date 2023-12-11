//
//  RegistrationView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import SwiftUI
import Charts
import SwiftUICharts


struct ClinicalView: View {
    
    @StateObject var viewModel: ClinicalViewModel
    
    //MARK: Sheet
    @State private var isDoctorSheetPresented = false
    @State private var isUnitSheetPresented = false
    @State private var isReferralSheetPresented = false
    @State private var isOperationSheetPresented = false
    @State private var isSicknessSheetPresented = false
    
    //MARK: Selection
    @State private var doctorDurationSelection: String?
    @State private var referralSelection: String?
    @State private var operationSelection: String?
    @State private var sicknesssSelection: String?
    @State private var encounterDurationSelection: String?
    
    //MARK: Closure
    var onChangeDoctorDuration: (()) -> Void
    var onChangeReferralReason: (()) -> Void
    var onChangeSickness: (()) -> Void
    var onChangeOperation: (()) -> Void
    var onChangeEncounterDuration: (()) -> Void
    
    //MARK: DoctorDurationView
    var doctorDurationView: some View{
        VStack{
            
            HeaderView(header: "Average Time Spent at Facility")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button {
                        Haptics.shared.play(.soft)
                        viewModel.selectedDoctorType = "DoctorDuration"
                        isDoctorSheetPresented.toggle()
                    } label: {
                        
                        VStack{
                            Image(systemName: "stethoscope")
                                .resizable()
                                .frame(width: 24, height: 20)
                            Text(viewModel.doctorDurationDoctor == nil ? "Doctor" : viewModel.doctorDurationDoctor?.name ?? "")
                                .font(.system(size: viewModel.doctorDurationDoctor == nil ? 10 : 12))
                            
                        }
                        .foregroundColor(viewModel.doctorDurationDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.doctorDurationDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                        
                    }
                    
                    if viewModel.doctorDurationDoctor != nil {
                        Button {
                            withAnimation {
                                viewModel.doctorDurationDoctor = nil
                                onChangeDoctorDuration(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Button {
                        viewModel.selectedUnitType = "DoctorDuration"
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "list.clipboard")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.doctorDurationUnit == nil ? "Specialty" : viewModel.doctorDurationUnit?.name ?? "")
                                .font(.system(size: viewModel.doctorDurationUnit == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.doctorDurationUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.doctorDurationUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.doctorDurationUnit != nil {
                        Button {
                            withAnimation {
                                viewModel.doctorDurationUnit = nil
                                onChangeDoctorDuration(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Spacer()
                    
                }
            }
            .frame(height: 50)
            
            if(viewModel.doctorDurationList.count > 0){
                
                Chart{
                    
                    ForEach(viewModel.doctorDurationList) { item in
                        BarMark(
                            x: .value("", item.encounter),
                            y: .value("DoctorName", item.doctorName)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 2){
                                //                                            Text("Encounter: ")
                                //                                                .font(.system(size: 8))
                                Text(item.encounter.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        BarMark(
                            x: .value("", item.waiting),
                            y: .value("DoctorName", item.doctorName)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 2){
                                //                                            Text("Waiting: ")
                                //                                                .font(.system(size: 8))
                                Text(item.waiting.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                    }
                    
                    if let doctorDurationSelection{
                        RuleMark(y: .value("DoctorName", doctorDurationSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForDoctor(viewModel.doctorDurationList[viewModel.doctorDurationList.index(doctorDurationSelection)], color: Color(hex: "8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $doctorDurationSelection)
                .chartXAxis(.hidden)
                .chartLegend(position: .bottom, alignment: .leading, spacing: 30)
                .cornerRadius(10)
                .frame(height: 400)
            }
            else{
              NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.encounterLoading {
                CustomLoadingView(imageName: "stethoscope.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: ReferralReasonView
    var referralReasonView: some View{
        VStack{
            HeaderView(header: "Referral Reason")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button {
                        viewModel.selectedDoctorType = "ReferralReason"
                        isDoctorSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        
                        VStack{
                            Image(systemName: "stethoscope")
                                .resizable()
                                .frame(width: 24, height: 20)
                            Text(viewModel.referralReasonDoctor == nil ? "Doctor" : viewModel.referralReasonDoctor?.name ?? "")
                                .font(.system(size: viewModel.referralReasonDoctor == nil ? 10 : 12))
                            
                        }
                        .foregroundColor(viewModel.referralReasonDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.referralReasonDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                    }
                    
                    if viewModel.referralReasonDoctor != nil {
                        Button {
                            withAnimation {
                                viewModel.referralReasonDoctor = nil
                                onChangeReferralReason(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Button {
                        viewModel.selectedUnitType = "ReferralReason"
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "list.clipboard")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.referralReasonUnit == nil ? "Specialty" : viewModel.referralReasonUnit?.name ?? "")
                                .font(.system(size: viewModel.referralReasonUnit == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.referralReasonUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.referralReasonUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.referralReasonUnit != nil {
                        Button {
                            withAnimation {
                                viewModel.referralReasonUnit = nil
                                onChangeReferralReason(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    
                    Button {
                        viewModel.selectedUnitType = "ReferralReason"
                        isReferralSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "info.circle")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.referralReasonType == nil ? "Referral Reason" : viewModel.referralReasonType?.name ?? "")
                                .font(.system(size: viewModel.referralReasonType == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.referralReasonType == nil ? .gray : Color(hex: "4194B3"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.referralReasonType == nil ? Color.gray : Color(hex: "4194B3"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.referralReasonType != nil {
                        Button {
                            withAnimation {
                                viewModel.referralReasonType = nil
                                onChangeReferralReason(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 50)
            if(viewModel.referralList.count > 0){
                
                Chart{
                    
                    ForEach(viewModel.referralList) { item in
                        BarMark(
                            x: .value("", item.valueInt),
                            y: .value("ValueText", item.valueText ?? "")
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                //                                            Text(item.valueText ?? "")
                                //                                                .font(.system(size: 8))
                                Text(item.valueInt.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                    }
                    if let referralSelection{
                        RuleMark(y: .value("ValueText", referralSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverView(viewModel.referralList[viewModel.referralList.index(referralSelection)], color: Color(hex: "8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $referralSelection)
                .chartXAxis(.hidden)
                .chartLegend(position: .bottom, alignment: .leading, spacing: 30)
                .cornerRadius(10)
                .frame(height: 400)
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.refferalLoading {
                CustomLoadingView(imageName: "stethoscope.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: OperationView
    var operationView: some View{
        VStack{
            HeaderView(header: "Top 10 Clinical Statistics")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button {
                        viewModel.selectedDoctorType = "Operation"
                        isDoctorSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        
                        VStack{
                            Image(systemName: "stethoscope")
                                .resizable()
                                .frame(width: 24, height: 20)
                            Text(viewModel.operationDoctor == nil ? "Doctor" : viewModel.operationDoctor?.name ?? "")
                                .font(.system(size: viewModel.operationDoctor == nil ? 10 : 12))
                            
                        }
                        .foregroundColor(viewModel.operationDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.operationDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                    }
                    
                    if viewModel.operationDoctor != nil {
                        Button {
                            withAnimation {
                                viewModel.operationDoctor = nil
                                onChangeOperation(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Button {
                        viewModel.selectedUnitType = "Operation"
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "list.clipboard")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.operationUnit == nil ? "Specialty" : viewModel.operationUnit?.name ?? "")
                                .font(.system(size: viewModel.operationUnit == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.operationUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.operationUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.operationUnit != nil {
                        Button {
                            withAnimation {
                                viewModel.operationUnit = nil
                                onChangeOperation(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Button {
                        viewModel.selectedUnitType = "Operation"
                        isOperationSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "allergens")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.operationType == nil ? "Type" : viewModel.operationType?.name ?? "")
                                .font(.system(size: viewModel.operationType == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.operationType == nil ? .gray : Color(hex: "4194B3"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.operationType == nil ? Color.gray : Color(hex: "4194B3"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.operationType != nil {
                        Button {
                            withAnimation {
                                viewModel.operationType = nil
                                onChangeOperation(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 50)
            
            if viewModel.operationList.count > 0{
                Chart{
                    ForEach(viewModel.operationList) { item
                        in
                        BarMark(
                            x: .value("", item.valueInt),
                            y: .value("ValueText", item.valueText ?? "")
                        )
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 2){
                                Text(item.valueInt.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                    }
                    if let operationSelection{
                        RuleMark(y: .value("ValueText", operationSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForOperation( viewModel.operationList[viewModel.operationList.index(operationSelection)], color: Color(hex: "8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $operationSelection)
                .chartLegend(position: .bottom, alignment: .leading, spacing: 30)
                //.chartLegend(.hidden)
                .cornerRadius(10)
                .frame(height: 600)
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.operationLoading {
                CustomLoadingView(imageName: "stethoscope.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: DiagnosisView
    var diagnosisView: some View{
        VStack{
            
        HeaderView(header: "Diagnostic Trends")
            
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack{
                
                Button {
                    isSicknessSheetPresented.toggle()
                    Haptics.shared.play(.soft)
                } label: {
                    VStack{
                        Image(systemName: "allergens")
                            .frame(width: 24, height: 20)
                        
                        Text(viewModel.selectedSickness == nil ? "Diagnosis" : viewModel.selectedSickness?.name ?? "")
                            .font(.system(size: viewModel.selectedSickness == nil ? 10 : 12))
                    }
                    .foregroundColor(viewModel.selectedSickness == nil ? .gray : Color(hex: "EB6796"))
                    .bold()
                    .padding(6)
                    .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.selectedSickness == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                    )
                }
                .padding(.leading, 4)
                
                if viewModel.selectedSickness != nil {
                    Button {
                        withAnimation {
                            viewModel.selectedSickness = nil
                            onChangeSickness(())
                            Haptics.shared.play(.soft)
                        }
                    } label: {
                        HStack(spacing: 2){
                            Image(systemName: "trash.slash")
                                .resizable()
                                .frame(width: 20, height: 24)
                        }
                        .foregroundColor(.red)
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                }
                
                Spacer()
                
            }
            
        }
        .frame(height: 50)
      
            if viewModel.sicknessList.count > 0{
                Chart{
                    ForEach(viewModel.sicknessList) { item
                        in
                        LineMark(
                            x: .value("ValueText", item.valueText ?? ""),
                            y: .value("", item.valueInt)
                        )
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                //                                            Text(item.valueText ?? "")
                                //                                                .font(.system(size: 8))
                                Text(item.valueInt.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        if let sicknesssSelection{
                            RuleMark(y: .value("ValueText", sicknesssSelection))
                                .foregroundStyle(.gray.opacity(0.35))
                                .zIndex(10)
                                .offset(yStart: -10)
                                .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                    Popup.shared.ChartPopOverView(viewModel.sicknessList[viewModel.sicknessList.index(sicknesssSelection)], color: Color(hex: "8A1538"))
                                }
                        }
                    }
                    
                }
                .chartLegend(position: .bottom, alignment: .leading, spacing: 30)
                //.chartLegend(.hidden)
                .cornerRadius(10)
                .frame(height: 400)
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.sicknessLoading {
                CustomLoadingView(imageName: "stethoscope.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: EncounterDurationView
    var encounterDurationView: some View{
        VStack{
            Text("Patient Waiting Time by Encounter Type".uppercased())
                .padding(.bottom, 10)
                .font(.system(size: 13))
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button {
                        viewModel.selectedDoctorType = "Encounter"
                        isDoctorSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        
                        VStack{
                            Image(systemName: "stethoscope")
                                .resizable()
                                .frame(width: 24, height: 20)
                            Text(viewModel.encounterDurationDoctor == nil ? "Doctor" : viewModel.encounterDurationDoctor?.name ?? "")
                                .font(.system(size: viewModel.encounterDurationDoctor == nil ? 10 : 12))
                            
                        }
                        .foregroundColor(viewModel.encounterDurationDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.encounterDurationDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                        
                    }
                    
                    if viewModel.encounterDurationDoctor != nil {
                        Button {
                            withAnimation {
                                viewModel.encounterDurationDoctor = nil
                                onChangeEncounterDuration(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    Button {
                        viewModel.selectedUnitType = "Encounter"
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "list.clipboard")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.encounterDurationUnit == nil ? "Specialty" : viewModel.encounterDurationUnit?.name ?? "")
                                .font(.system(size: viewModel.encounterDurationUnit == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.encounterDurationUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.encounterDurationUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.encounterDurationUnit != nil {
                        Button {
                            withAnimation {
                                viewModel.encounterDurationUnit = nil
                                onChangeEncounterDuration(())
                                Haptics.shared.play(.soft)
                            }
                        } label: {
                            HStack(spacing: 2){
                                Image(systemName: "trash.slash")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .padding(6)
                            .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                        }
                        .padding(.leading, 4)
                    }
                    
                    
                    Spacer()
                    
                }
            }
            .frame(height: 50)
            
            if(viewModel.encounterDurationList.count > 0){
                
                Chart{
                    
                    ForEach(viewModel.encounterDurationList) { item in
                        BarMark(
                            x: .value("", item.encounter),
                            y: .value("ComeType", item.comeType ?? "Unknown")
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                //                                        Text("Encounter")
                                //                                            .font(.system(size: 8))
                                Text(item.encounter.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        BarMark(
                            x: .value("", item.waiting),
                            y: .value("", item.comeType ?? "Unknown")
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                //                                        Text("Waiting")
                                //                                            .font(.system(size: 8))
                                Text(item.waiting.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                    }
                    if let encounterDurationSelection{
                        RuleMark(y: .value("ComeType", encounterDurationSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForEncounter(viewModel.encounterDurationList[viewModel.encounterDurationList.index(encounterDurationSelection)], color: Color(hex: "8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $encounterDurationSelection)
                .chartXAxis(.hidden)
                .chartLegend(position: .bottom, alignment: .leading, spacing: 30)
                .cornerRadius(10)
                .frame(height: 400)
            }
            else{
                NoRecordView()
            }
        }
        .overlay(content: {
            if viewModel.encounterLoading {
                CustomLoadingView(imageName: "stethoscope.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: Main
    var body: some View {
        VStack{
            
            ScrollView{
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0){
                        
                        
                        doctorDurationView
                        
                        Divider()
                            .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                            .frame(height: 2) // Divider'ın kalınlığını belirle
                            .padding()
                        
                        referralReasonView

                        Divider()
                            .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                            .frame(height: 2) // Divider'ın kalınlığını belirle
                            .padding()
                        

                        operationView
                        
                        Divider()
                            .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                            .frame(height: 2) // Divider'ın kalınlığını belirle
                            .padding()
                        
                        
                        diagnosisView
                        
                        
                        Divider()
                            .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                            .frame(height: 2) // Divider'ın kalınlığını belirle
                            .padding()
                        
                        encounterDurationView
                       
                    }
                    
                    
                }
                
                .padding()
                
            }
            .navigationTitle("Clinical")
            .sheet(isPresented: $isSicknessSheetPresented) {
                SicknessListView { selectedSickness in
                    viewModel.selectedSickness = selectedSickness
                    onChangeSickness(())
                }
                .presentationDetents([.large, .medium])
            }
            .sheet(isPresented: $isOperationSheetPresented) {
                SelectorListView(selectorType: .operation, onSelection:{ selectedItem in
                    viewModel.operationType = selectedItem
                    onChangeOperation(())
                })
                .presentationDetents([.large, .medium])
            }
            .sheet(isPresented: $isReferralSheetPresented) {
                SelectorListView(selectorType: .referralReason, onSelection:{ selectedItem in
                    viewModel.referralReasonType = selectedItem
                    onChangeReferralReason(())
                })
                .presentationDetents([.large, .medium])
            }
            .sheet(isPresented: $isDoctorSheetPresented) {
                DoctorListView(onDoctorSelection: { doctor in
                    withAnimation {
                        if viewModel.selectedDoctorType == "DoctorDuration"{
                            viewModel.doctorDurationDoctor = doctor
                            onChangeDoctorDuration(())
                        }
                        else if viewModel.selectedDoctorType == "ReferralReason"{
                            viewModel.referralReasonDoctor = doctor
                            onChangeReferralReason(())
                        }
                        else if viewModel.selectedDoctorType == "Operation"{
                            viewModel.operationDoctor = doctor
                            onChangeOperation(())
                        }
                        else if viewModel.selectedDoctorType == "Encounter"{
                            viewModel.encounterDurationDoctor = doctor
                            onChangeEncounterDuration(())
                        }
                        
                    }
                })
                .presentationDetents([.large, .medium])
            }
            .sheet(isPresented: $isUnitSheetPresented) {
                UnitListView(onUnitSelection: { selectedUnit in
                    withAnimation {
                        if viewModel.selectedUnitType == "DoctorDuration"{
                            viewModel.doctorDurationUnit = selectedUnit
                            onChangeDoctorDuration(())
                        }
                        else if viewModel.selectedUnitType == "ReferralReason"{
                            viewModel.referralReasonUnit = selectedUnit
                            onChangeReferralReason(())
                        }
                        else if viewModel.selectedUnitType == "Operation"{
                            viewModel.operationUnit = selectedUnit
                            onChangeOperation(())
                        }
                        else if viewModel.selectedUnitType == "Encounter"{
                            viewModel.encounterDurationUnit = selectedUnit
                            onChangeEncounterDuration(())
                        }
                    }
                })
                .presentationDetents([.large, .medium])
            }
        }
    }
}

#Preview {
    MainTabView()
}
