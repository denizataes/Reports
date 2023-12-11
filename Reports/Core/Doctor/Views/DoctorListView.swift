//
//  DoctorListView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import SwiftUI

struct DoctorListView: View {
    @StateObject var viewModel = DoctorViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDoctor: DetailedDoctor? = nil
    var onDoctorSelection: (DetailedDoctor) -> Void // Closure to handle doctor selection

    @State private var searchText = ""
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Text("🧑🏼‍⚕️👩🏼‍⚕️")
                    .font(.title)
                    .shadow(radius: 2)
                
                Spacer()
                
                Button {
                    dismiss()
                    Haptics.shared.play(.soft)
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(Color(hex: "009c80"))
                        .bold()
                        .shadow(radius: 1)
                }
                
            }
            .padding()
            
            ZStack(alignment: .trailing) {
                TextField("Search Doctor...", text: $searchText)
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
                        searchText = ""
                        Haptics.shared.play(.soft)
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
                    ForEach(viewModel.doctorList.filter {
                        searchText.isEmpty  ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                    }) { doctor in
                        DoctorView(doctor: doctor) { detailedDoctor in
                            onDoctorSelection(detailedDoctor)
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
