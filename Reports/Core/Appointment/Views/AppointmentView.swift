//
//  RegistrationView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import SwiftUI
import Charts
import SwiftUICharts


struct AppointmentView: View {
    
    @StateObject var viewModel: AppointmentViewModel
    
    //MARK: Sheet
    @State private var isDoctorSheetPresented = false
    @State private var isUnitSheetPresented = false
    
    //MARK: Closures
    var onChangeHistory: (()) -> Void
    var onChangeCurrent: (()) -> Void
    
    //MARK: Popup selection
    @State private var historySelection: String?
    @State private var currentSelection: String?
    @State private var nationalitySelection: String?
    @State private var ageSelection: String?
    
    //MARK: HistoryChartView
    var historyView: some View{
        
        VStack{
            
            HeaderView(header: "Utilized Capacity")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button {
                        viewModel.selectedDoctorType = "History"
                        isDoctorSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        
                        VStack{
                            Image(systemName: "stethoscope")
                                .resizable()
                                .frame(width: 24, height: 20)
                            Text(viewModel.historyCapacityDoctor == nil ? "Doctor" : viewModel.historyCapacityDoctor?.name ?? "")
                                .font(.system(size: viewModel.historyCapacityDoctor == nil ? 10 : 12))
                            
                        }
                        .foregroundColor(viewModel.historyCapacityDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.historyCapacityDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                    }
                    
                    if viewModel.historyCapacityDoctor != nil {
                        Button {
                            withAnimation {
                                viewModel.historyCapacityDoctor = nil
                                onChangeHistory(())
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
                        viewModel.selectedUnitType = "History"
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "list.clipboard")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.historyCapacityUnit == nil ? "Specialty" : viewModel.historyCapacityUnit?.name ?? "")
                                .font(.system(size: viewModel.historyCapacityUnit == nil ? 10 : 12))
                        }
                        .foregroundColor(viewModel.historyCapacityUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.historyCapacityUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    .padding(.leading, 4)
                    
                    if viewModel.historyCapacityUnit != nil {
                        Button {
                            withAnimation {
                                viewModel.historyCapacityUnit = nil
                                onChangeHistory(())
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
            
            if(viewModel.historyCapacityList.count > 0){
                
                Chart{
                    
                    ForEach(viewModel.historyCapacityList) { item in
                        BarMark(
                            x: .value("", item.full),
                            y: .value("Type", item.type)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                Text(item.full.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        BarMark(
                            x: .value("", item.empty),
                            y: .value("Type", item.type)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                Text(item.empty.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                    }
                    
                    if let historySelection{
                        RuleMark(y: .value("Type", historySelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForCapacity(viewModel.historyCapacityList[viewModel.historyCapacityList.index(historySelection)], color: Color(hex: "#0D4261"))
                            }
                        
                    }
                }
                .chartYSelection(value: $historySelection)
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
            if viewModel.historyLoading {
                CustomLoadingView(imageName: "calendar.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: CurrentChartView
    var currentView: some View{
        VStack{
            
           HeaderView(header: "Current Capacity")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button {
                        isDoctorSheetPresented.toggle()
                        viewModel.selectedDoctorType = "Current"
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "stethoscope")
                                .resizable()
                                .frame(width: 24, height: 20)
                            Text(viewModel.currentCapacityDoctor == nil ? "Doctor" : viewModel.currentCapacityDoctor?.name ?? "")
                                .font(.system(size: 10))
                                .bold()
                        }
                        .foregroundColor(viewModel.currentCapacityDoctor == nil ? .gray : Color(hex: "009c80"))
                        .bold()
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.currentCapacityDoctor == nil ? Color.gray : Color(hex: "009c80"), lineWidth: 1)
                        )
                    }
                    
                    if viewModel.currentCapacityDoctor != nil {
                        Button {
                            withAnimation {
                                viewModel.currentCapacityDoctor = nil
                                onChangeCurrent(())
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
                        viewModel.selectedUnitType = "Current"
                        isUnitSheetPresented.toggle()
                        Haptics.shared.play(.soft)
                    } label: {
                        VStack{
                            Image(systemName: "list.clipboard")
                                .frame(width: 24, height: 20)
                            
                            Text(viewModel.currentCapacityUnit == nil ? "Specialty" : viewModel.currentCapacityUnit?.name ?? "")
                                .font(.system(size: 10))
                                .bold()
                        }
                        .foregroundColor(viewModel.currentCapacityUnit == nil ? .gray : Color(hex: "EB6796"))
                        .bold()
                        .padding(6)
                        .cornerRadius(10) // Yarıçapını ayarlayarak oval bir çerçeve oluşturabilirsiniz
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.currentCapacityUnit == nil ? Color.gray : Color(hex: "EB6796"), lineWidth: 1)
                        )
                    }
                    
                    if viewModel.currentCapacityUnit != nil {
                        Button {
                            withAnimation {
                                viewModel.currentCapacityUnit = nil
                                onChangeCurrent(())
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
            
            if(viewModel.currentCapacityList.count > 0){
                
                Chart{
                    
                    ForEach(viewModel.currentCapacityList) { item in
                        BarMark(
                            x: .value("", item.full),
                            y: .value("Type", item.type)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                //                                        Text("Full")
                                //                                            .font(.system(size: 8))
                                Text(item.full.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        BarMark(
                            x: .value("", item.empty),
                            y: .value("Type", item.type)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            VStack(spacing: 0){
                                //                                        Text("Empty")
                                //                                            .font(.system(size: 8))
                                Text(item.empty.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                    }
                    
                    if let currentSelection{
                        RuleMark(y: .value("Type", currentSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForCapacity(viewModel.currentCapacityList[viewModel.currentCapacityList.index(currentSelection)], color: Color(hex: "#0D4261"))
                            }
                    }
                }
                .chartYSelection(value: $currentSelection)
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
            if viewModel.currentLoading {
                CustomLoadingView(imageName: "calendar.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: NationalityView
    var nationalityView: some View{
        VStack{
            
            HeaderView(header: "Number of patients by nationality and gender")
            
            
            if viewModel.nationalityList.count > 0{
                Chart{
                    ForEach(viewModel.nationalityList) { item
                        in
                        BarMark(
                            x: .value("Erkek", item.male),
                            y: .value("Ülke Adları", item.countryName)
                        )
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 0){
//                                            Text("Male:")
//                                                .font(.system(size: 8))
                                Text(item.male.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        
                        
                        
                        
                        BarMark(
                            x: .value("Kadın", item.female),
                            y: .value("Ülke Adları", item.countryName)
                        )
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 0){
//                                            Text("Female:")
//                                                .font(.system(size: 8))
                                Text(item.female.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        BarMark(
                            x: .value("Belirsiz", item.unknown),
                            y: .value("Ülke Adları", item.countryName)
                        )
                        .foregroundStyle(Color(hex: "4194B3"))
                        
                        BarMark(
                            x: .value("Diğer", item.other),
                            y: .value("Ülke Adları", item.countryName)
                        )
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 0){
//                                            Text("Other:")
//                                                .font(.system(size: 8))
                                Text(item.other.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }
                            .foregroundStyle(.white)
                            
                        }
                        .foregroundStyle(Color(hex:"FDF39E"))
                        
                        
                    }
                    
                    if let nationalitySelection{
                        RuleMark(y: .value("Ülke Adları", nationalitySelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForNationality(viewModel.nationalityList[viewModel.nationalityList.index(nationalitySelection)], color: Color(hex: "#8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $nationalitySelection)
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
            if viewModel.nationalityLoading {
                CustomLoadingView(imageName: "calendar.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: AgeView
    var ageView: some View{
        VStack{
            
            HeaderView(header: "Number of patients by age group and gender")
            
            
            if viewModel.ageList.count > 0{
                Chart{
                    ForEach(viewModel.ageList) { item
                        in
                        BarMark(
                            x: .value("Erkek", item.male),
                            y: .value("Type", item.type)
                        )
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 0){
                                //                                        Text("Male:")
                                //                                            .font(.system(size: 8))
                                Text(item.male.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        
                        
                        
                        
                        BarMark(
                            x: .value("Kadın", item.female),
                            y: .value("Type", item.type)
                        )
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation(position: .overlay){
                            
                            HStack(spacing: 0){
                                //                                        Text("Female:")
                                //                                            .font(.system(size: 8))
                                Text(item.female.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }.foregroundStyle(.white)
                            
                        }
                        
                        
                        
                    }
                    
                    if let ageSelection{
                        RuleMark(y: .value("Type", ageSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverViewForAge(viewModel.ageList[viewModel.ageList.index(ageSelection)], color: Color(hex: "#8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $ageSelection)
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
            if viewModel.ageLoading {
                CustomLoadingView(imageName: "calendar.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: Main
    var body: some View {
        VStack{
            
            ScrollView{
                
                VStack(alignment: .leading) {
                  
                    historyView
                    
                    Divider()
                        .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                        .frame(height: 2) // Divider'ın kalınlığını belirle
                        .padding()
                    
                    
                    currentView
                    
                    
                    Divider()
                        .background(Color(hex: "#8A1538"))
                        .frame(height: 2)
                        .padding()
                
                    
                    nationalityView
                    
                    
                    Divider()
                        .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                        .frame(height: 2) // Divider'ın kalınlığını belirle
                        .padding()
                    
                    ageView
                    
                    
                }
                .padding()
                
            }
            .navigationTitle("Appointment")
            .sheet(isPresented: $isDoctorSheetPresented) {
                DoctorListView(onDoctorSelection: { doctor in
                    withAnimation {
                        if viewModel.selectedDoctorType == "Current"{
                            viewModel.currentCapacityDoctor = doctor
                            onChangeCurrent(())
                        }
                        else{
                            viewModel.historyCapacityDoctor = doctor
                            onChangeHistory(())
                        }
                        
                    }
                })
                .presentationDetents([.large, .medium])
            }
            .sheet(isPresented: $isUnitSheetPresented) {
                UnitListView(onUnitSelection: { selectedUnit in
                    withAnimation {
                        if viewModel.selectedUnitType == "Current"{
                            viewModel.currentCapacityUnit = selectedUnit
                            onChangeCurrent(())
                        }
                        else{
                            viewModel.historyCapacityUnit = selectedUnit
                            onChangeHistory(())
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
