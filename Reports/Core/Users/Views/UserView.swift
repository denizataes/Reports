//
//  UnitView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 20.11.2023.
//

import SwiftUI

struct UserView: View {
    @State var isSelected: Bool = false
    var user: ResultModel
    var onSelection: (ResultModel) -> Void
    
    var body: some View {
        Button {
            isSelected.toggle()
            onSelection(user)
            Haptics.shared.play(.soft)
        } label: {
            HStack{
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundStyle(.gray)
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading){
                    Text(user.name)
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
    UserView(user: ResultModel(objectID: 122, name: "Deniz Ata EŞ")) { user in
        
    }
}
