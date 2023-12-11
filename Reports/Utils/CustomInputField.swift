//
//  CustomInputField.swift
//  TwitterSwiftUI
//
//  Created by Deniz Ata Eş on 19.11.2022.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeHolderText: String
    @Binding var text: String
    var isSecureField: Bool? = false
    var isIP: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundColor(Color(hex: "A29475"))
                
                if isSecureField ?? false{
                    SecureField(placeHolderText, text: $text)
                        .foregroundColor(Color(hex: "A29475"))
                        .accentColor(Color(hex: "A29475"))

                }else
                {
                    TextField(placeHolderText, text: $text)
                        .foregroundColor(Color(hex: "A29475"))
                        .accentColor(Color(hex: "A29475"))
                        .onChange(of: text) { _, newValue in
                            if isIP{
                                text = newValue.filter { "0123456789.".contains($0) }
                            }
                        }
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            Divider()
                .background(Color(.darkGray))
            
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeHolderText: "Email", text: .constant(""), isSecureField: true)
    }
}
