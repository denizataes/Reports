//
//  UnitView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 20.11.2023.
//

import SwiftUI

struct SelectorView: View {
    @State var isSelected: Bool = false
    var selected: ResultModel
    var onSelection: (ResultModel) -> Void
    var selectedType: SelectorType
    
    
    var body: some View {
        Button {
            Haptics.shared.play(.soft)
            isSelected.toggle()
            onSelection(selected)
        } label: {
            HStack{
                Image(systemName: selectedType.imageName)
                    .resizable()
                    .foregroundStyle(.gray)
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading){
                    Text(selected.name)
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
    SelectorView(selected: .init(objectID: 1, name: "test"), onSelection: { _ in
        
    }, selectedType: .referralReason)
}
