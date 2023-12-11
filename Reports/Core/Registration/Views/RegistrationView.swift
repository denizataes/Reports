//
//  RegistrationView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import SwiftUI
import Charts
import SwiftUICharts


struct RegistrationView: View {
    
    @StateObject var viewModel: RegistrationViewModel
    
    //MARK: Popup selection
    @State private var encounterTypeSelection: String?
    @State private var encounterStatusSelection: String?
    @State private var nationalitySelection: String?
    @State private var ageSelection: String?
    
    //MARK: EncounterType
    var encounterTypeView: some View{
        VStack{
      
            HeaderView(header: "Number of Patients by Encounter Type")
            
            if(viewModel.encounterTypeList.count > 0){
                
                Chart{
                    
                    ForEach(viewModel.encounterTypeList) { item in
                        BarMark(
                            x: .value("", item.valueText ?? ""),
                            y: .value("", item.valueInt)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#009C80"))
                        .annotation{
                            
                            VStack(spacing: 0){
                                Text(item.valueText ?? "")
                                    .font(.system(size: 8))
                                Text(item.valueInt.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }
                            
                        }
                        
                    }
                    
                    if let encounterTypeSelection{
                        RuleMark(x: .value("ValueInt", encounterTypeSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverView(viewModel.encounterTypeList[viewModel.encounterTypeList.index(encounterTypeSelection)], color: Color(hex: "#0D4261"))
                            }
                        
                    }
                }
                .chartXSelection(value: $encounterTypeSelection)
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
            if viewModel.encounterTypeLoading {
                CustomLoadingView(imageName: "heart.circle", imageColor: "009C80")
            }
        })
        
    }
    
    //MARK: EncounterStatus
    var encounterStatusView: some View{
        VStack{
            HeaderView(header: "Number of Patients by Encounter Status")
            
            if(viewModel.encounterStatusList.count > 0){
                
                Chart{
                    ForEach(viewModel.encounterStatusList) { item in
                        BarMark(
                            x: .value("", item.valueText ?? ""),
                            y: .value("", item.valueInt)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(Color(hex: "#0D4261"))
                        .annotation{
                            
                            VStack(spacing: 0){
                                Text(item.valueText ?? "")
                                    .font(.system(size: 8))
                                Text(item.valueInt.description)
                                    .font(.system(size: 10))
                                    .bold()
                                
                            }
                            
                        }
                    }
                    if let encounterStatusSelection{
                        RuleMark(x: .value("ValueInt", encounterStatusSelection))
                            .foregroundStyle(.gray.opacity(0.35))
                            .zIndex(10)
                            .offset(yStart: -10)
                            .annotation(position: .overlay, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
                                Popup.shared.ChartPopOverView(viewModel.encounterStatusList[viewModel.encounterStatusList.index(encounterStatusSelection)], color: Color(hex: "#009C80"))
                            }
                        
                    }
                }
                .chartXSelection(value: $encounterStatusSelection)
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
            if viewModel.encounterStatusLoading {
                CustomLoadingView(imageName: "heart.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: Nationality
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
                                //Text("Male:")
                                //.font(.system(size: 8))
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
                                //Text("Female:")
                                //.font(.system(size: 8))
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
                                Popup.shared.ChartPopOverViewForNationality(viewModel.nationalityList[viewModel.nationalityList.index(nationalitySelection)], color: Color(hex: "8A1538"))
                            }
                    }
                }
                .chartYSelection(value: $nationalitySelection)
                .chartLegend(position: .bottom, alignment: .leading, spacing: 30)
                //.chartScrollableAxes(.horizontal)
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
                CustomLoadingView(imageName: "heart.circle", imageColor: "009C80")
            }
            
        })
    }
    
    //MARK: Age
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
                                Popup.shared.ChartPopOverViewForAge(viewModel.ageList[viewModel.ageList.index(ageSelection)], color: Color(hex: "8A1538"))
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
                CustomLoadingView(imageName: "heart.circle", imageColor: "009C80")
            }
        })
    }
    
    //MARK: Main
    var body: some View {
        VStack{
            
            ScrollView{
                
                VStack{
                    
                    encounterTypeView
                    
                    Divider()
                        .background(Color(hex: "#8A1538"))
                        .frame(height: 2)
                        .padding()
                    
                    encounterStatusView
                    
                    Divider()
                        .background(Color(hex: "#8A1538")) // Divider'ın rengini belirle
                        .frame(height: 2) // Divider'ın kalınlığını belirle
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
            .navigationTitle("Registration")
            
        }
    }
    
}

#Preview {
    MainTabView()
}
