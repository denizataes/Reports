//
//  IPView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import SwiftUI

struct IPView: View {
    @StateObject var viewModel: IPViewModel
    @State private var showIPRequired: Bool = true
    var body: some View {
        VStack {
            VStack{
                Text("Welcome to")
                    .font(.system(size: 28))
                Text("Reports")
                    .font(.system(size: 48))
                    .bold()
                    .foregroundStyle(Color(hex: "8A1538"))
                    .shadow(radius: 1)
            }
                
           Spacer()
             
            VStack(spacing: 4){
                Text("Enter your hospital IP to login.")
                    .bold()
                    .padding(.bottom, 50)
                    .foregroundStyle(Color(hex: "A29475"))
                
                VStack(alignment: .leading){
                    CustomInputField(imageName: "network.badge.shield.half.filled", placeHolderText: "Enter IP", text: $viewModel.userEnteredURL, isIP: true)
                        .onChange(of: viewModel.userEnteredURL, { _, newValue in
                            withAnimation {
                                let trimmedValue = newValue.trimmingCharacters(in: .whitespaces)
                                if trimmedValue.isEmpty{
                                    showIPRequired = true
                                }
                                else{
                                    showIPRequired = false
                                }
                            }
                        })
                        

                    if(showIPRequired){
                        Text("IP is required!")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "4194B3"))
                            .bold()
                    }
                    else if(!viewModel.userEnteredURL.isIPAddress()){
                        Text("Required format is X.X.X.X")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "4194B3"))
                            .bold()
                    }
                }
                .padding(.bottom, 50)
                
                Button("Next") {
                    Haptics.shared.play(.soft)
                    closeKeyboard()
                    let trimmedIP = viewModel.userEnteredURL.trimmingCharacters(in: .whitespaces)
                    
                    if trimmedIP.isEmpty{
                        withAnimation {
                            showIPRequired = true
                        }
                    }
                    else {
                        viewModel.checkkAndloginIP()
                        Haptics.shared.play(.medium)
                    }
                    
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background((Color(hex: "8A1538")))
                .cornerRadius(10)
                .shadow(radius: 10)
                .disableWithOpacity(
                    viewModel.userEnteredURL.trimmingCharacters(in: .whitespaces).isEmpty || !viewModel.userEnteredURL.isIPAddress()
                )
                
            }
            Spacer()
        }
        .padding()
        .overlay(content: {
            if viewModel.loading {
                CustomLoadingView(imageName: "r.circle")
            }
        })
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
        }
    }
}

#Preview {
    IPView(viewModel: IPViewModel())
}
