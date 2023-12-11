//
//  Popup.swift
//  Reports
//
//  Created by Deniz Ata Eş on 23.11.2023.
//

import Foundation
import SwiftUI
class Popup {
    static let shared = Popup()
    
    private init() { }
    
    
    @ViewBuilder
    func ChartPopOverView(_ model: StatisticModel, color: Color = .gray) -> some View {
        VStack {
            Text(model.valueText ?? "")
                .font(.system(size: 12))
                .padding(.bottom, 5)      // Alt boşluk ekleniyor
                .fixedSize()

            Text(model.valueInt.description)
                .font(.system(size: 14))
                .bold()

        }
        .foregroundStyle(.white)
        .padding(10)
        .background(color.opacity(0.8))
        .cornerRadius(10)
        .frame(width: 100, height: 60)
    }
    
    
    
    @ViewBuilder
    func ChartPopOverViewForNationality(_ model: NationalityData, color: Color = .gray) -> some View {
        VStack{
            
                Text(model.countryName)
                    .font(.system(size: 12))
                    .fixedSize()
                    .bold()
            
            Divider()
            
            VStack(alignment: .leading){
                if model.male > 0{
                    HStack{
                        Text("Male: ")
                            .font(.system(size: 12))
                        Text(model.male.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.female > 0{
                    HStack{
                        Text("Female: ")
                            .font(.system(size: 12))
                        Text(model.female.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.other > 0{
                    HStack{
                        Text("Other: ")
                            .font(.system(size: 12))
                        Text(model.other.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.unknown > 0{
                    HStack{
                        Text("Unknown: ")
                            .font(.system(size: 12))
                        Text(model.unknown.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
            }

        }
        .foregroundStyle(.white)
        .padding(5)                      // Kenar boşlukları ekleniyor
        .background(color.opacity(0.8))  // Hafif transparan gri arka plan
        .cornerRadius(10)                 // Köşeleri yumuşat
        .shadow(radius: 5)
        .frame(maxHeight: 80)    // Genişlik ve yükseklik belirleniyor
    }
    
    @ViewBuilder
    func ChartPopOverViewForOperation(_ model: StatisticModel, color: Color = .gray) -> some View {
        VStack {
            Text(model.valueText ?? "")
                .font(.system(size: 12))
                .multilineTextAlignment(.center) // Metni ortala
                .frame(maxWidth: .infinity) // En fazla genişliğe kadar genişlet
                .padding(.bottom, 5)

            Text(model.valueInt.description)
                .font(.system(size: 14))
                .bold()
        }
        .foregroundStyle(.white)
        .padding(10)
        .background(color.opacity(0.8))
        .cornerRadius(10)
        .frame(maxWidth: .infinity) // En fazla genişliğe kadar genişlet
        .frame(height: 60) // Sabit yükseklik
    }
    
    @ViewBuilder
    func ChartPopOverViewForCapacity(_ model: Capacity, color: Color = .gray) -> some View {
        VStack{
            
            Text(model.type)
                    .font(.system(size: 12))
                    .fixedSize()
                    .bold()
            
            Divider()
            
            VStack(alignment: .leading){
                if model.full > 0{
                    HStack{
                        Text("Full: ")
                            .font(.system(size: 12))
                        Text(model.full.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.empty > 0{
                    HStack{
                        Text("Empty: ")
                            .font(.system(size: 12))
                        Text(model.empty.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
            }

        }
        .foregroundStyle(.white)
        .padding(5)                      // Kenar boşlukları ekleniyor
        .background(color.opacity(0.8))  // Hafif transparan gri arka plan
        .cornerRadius(10)                 // Köşeleri yumuşat
        .shadow(radius: 5)
        .frame(maxHeight: 80)    // Genişlik ve yükseklik belirleniyor
    }
    
    
    @ViewBuilder
    func ChartPopOverViewForAge(_ model: AgeGenderData, color: Color = .gray) -> some View {
        VStack{
            
            Text(model.type)
                    .font(.system(size: 12))
                    .fixedSize()
                    .bold()
            
            Divider()
            
            VStack(alignment: .leading){
                if model.male > 0{
                    HStack{
                        Text("Male: ")
                            .font(.system(size: 12))
                        Text(model.male.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.female > 0{
                    HStack{
                        Text("Female: ")
                            .font(.system(size: 12))
                        Text(model.female.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
            }

        }
        .foregroundStyle(.white)
        .padding(5)                      // Kenar boşlukları ekleniyor
        .background(color.opacity(0.8))  // Hafif transparan gri arka plan
        .cornerRadius(10)                 // Köşeleri yumuşat
        .shadow(radius: 5)
        .frame(maxHeight: 80)    // Genişlik ve yükseklik belirleniyor
    }
    
    @ViewBuilder
    func ChartPopOverViewForDoctor(_ model: DoctorModel, color: Color = .gray) -> some View {
        VStack{
            
            Text(model.doctorName)
                    .font(.system(size: 12))
                    .fixedSize()
                    .bold()
            
            Divider()
            
            VStack(alignment: .leading){
                if model.waiting > 0{
                    HStack{
                        Text("Waiting: ")
                            .font(.system(size: 12))
                        Text(model.waiting.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.encounter > 0{
                    HStack{
                        Text("Encounter: ")
                            .font(.system(size: 12))
                        Text(model.encounter.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
            }

        }
        .foregroundStyle(.white)
        .padding(5)                      // Kenar boşlukları ekleniyor
        .background(color.opacity(0.8))  // Hafif transparan gri arka plan
        .cornerRadius(10)                 // Köşeleri yumuşat
        .shadow(radius: 5)
        .frame(maxHeight: 80)    // Genişlik ve yükseklik belirleniyor
    }
    
    @ViewBuilder
    func ChartPopOverViewForEncounter(_ model: EncounterModel, color: Color = .gray) -> some View {
        VStack{
            
            Text(model.comeType ?? "")
                    .font(.system(size: 12))
                    .fixedSize()
                    .bold()
            
            Divider()
            
            VStack(alignment: .leading){
                if model.waiting > 0{
                    HStack{
                        Text("Waiting: ")
                            .font(.system(size: 12))
                        Text(model.waiting.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
                
                if model.encounter > 0{
                    HStack{
                        Text("Encounter: ")
                            .font(.system(size: 12))
                        Text(model.encounter.description)
                            .font(.system(size: 12))
                            .bold()
                    }
                }
            }

        }
        .foregroundStyle(.white)
        .padding(5)                      // Kenar boşlukları ekleniyor
        .background(color.opacity(0.8))  // Hafif transparan gri arka plan
        .cornerRadius(10)                 // Köşeleri yumuşat
        .shadow(radius: 5)
        .frame(maxHeight: 80)    // Genişlik ve yükseklik belirleniyor
    }
    
    
}
