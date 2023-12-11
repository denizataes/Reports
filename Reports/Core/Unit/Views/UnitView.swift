//
//  UnitView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 20.11.2023.
//

import SwiftUI

struct UnitView: View {
    @State var isSelected: Bool = false
    var unit: ResultModel
    var onSelection: (ResultModel) -> Void
    
    var body: some View {
        Button {
            Haptics.shared.play(.soft)
            isSelected.toggle()
            onSelection(unit)
        } label: {
            HStack{
                Image(systemName: "stethoscope")
                    .resizable()
                    .foregroundStyle(.gray)
                    .frame(width: 40, height: 32)
                
                VStack(alignment: .leading){
                    Text(unit.name)
                        .bold()
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

#Preview {
    UnitView(unit: ResultModel(objectID: 122, name: "Family")) { unit in
        print(unit)
    }
}
