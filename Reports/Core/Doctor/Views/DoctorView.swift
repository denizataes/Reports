//
//  DoctorView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import SwiftUI

struct DoctorView: View {
    @State var isSelected: Bool = false
    var doctor: DetailedDoctor
    var onSelection: (DetailedDoctor) -> Void
    var body: some View {
        
        Button {
            isSelected.toggle()
            onSelection(doctor) 
            Haptics.shared.play(.soft)
        } label: {
            HStack{
                Image(doctor.gender == "Male" ?  "maleDoctor" : "femaleDoctor")
                    .resizable()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading){
                    Text(doctor.name)
                        .bold()
                    
                    Text("QID: " + doctor.identityNumber)
                        .font(.footnote)
                    Text("Age: " + (doctor.birthDate?.age().description ?? "Unknown"))
                        .font(.caption2)
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(isSelected ? Color(hex: "009c80") : Color(hex: "8A1538"))
            }
            
        }
        .frame(height: 45)
        .padding()
        
        Divider()
            .background(Color(hex: "#8A1538")) 
            .padding(.horizontal)
    }
}

//#Preview {
//    DoctorView(doctor: DetailedDoctor(objectID: 1, name: "Ahmet Yıldırım", gender: "Male", userID: 1, unitName: "Family", identityNumber: "124124593234", role: "DOCTOR", birthDate: Date()))
//}
