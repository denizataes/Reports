//
//  DoctorListView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import SwiftUI

struct UnitListView: View {
    @StateObject var viewModel = UnitViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var selectedUnit: ResultModel? = nil
    var onUnitSelection: (ResultModel) -> Void

    @State private var searchText = ""
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Text("Speciality")
                    .font(.title)
                    .shadow(radius: 2)
                
                Spacer()
                
                Button {
                    Haptics.shared.play(.soft)
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(Color(hex: "009c80"))
                        .bold()
                        .shadow(radius: 1)
                }
                
            }
            .padding()
            
            ZStack(alignment: .trailing) {
                TextField("Search Unit...", text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                    .bold()
                    .shadow(radius: 10)
                
                if !searchText.isEmpty {
                    Button(action: {
                        Haptics.shared.play(.soft)
                        searchText = ""
                    }) {
                        Image(systemName: "multiply")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 16)
                            .padding(.trailing, 10)
                    }
                }
            }
            
            
            ScrollView{
                VStack{
                    ForEach(viewModel.unitList.filter {
                        searchText.isEmpty  ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                    }) { unit in
                        UnitView(unit: unit) { unit in
                            onUnitSelection(unit)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    NavigationView{
//
//    }
//}
