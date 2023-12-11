//
//  TitleView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 24.11.2023.
//

import SwiftUI

struct HeaderView: View {
    var header: String
    var body: some View {
        VStack{
            Text(header.uppercased())
                .padding(.bottom, 10)
                .font(.system(size: 13))
                .bold()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    HeaderView(header: "Reports")
}
