//
//  NoRecordView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 24.11.2023.
//

import SwiftUI

struct NoRecordView: View {
    var body: some View {
        
        HStack{
            Spacer()
            
            Text("No record found, please change search filter.")
                    .bold()
                    .font(.system(size: 10))
            Spacer()
        }
        
        .frame(maxWidth: 250, maxHeight: 30)
        .padding()
        .background(Color(hex: "A29475").opacity(0.2).shadow(.inner(radius: 1)))
        .cornerRadius(20)
        
        
        
    }
}

#Preview {
    NoRecordView()
}
