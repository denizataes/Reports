//
//  LoginView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 22.11.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: LoginViewModel
    
    //MARK: ErrorProperties
    @State private var showUserRequired: Bool = true
    @State private var showPasswordRequired: Bool = true
    
    
    var body: some View {
        VStack{
        LoginHeaderView(title: "Meet Reports", description: "Log In to Begin!")
            
            VStack(spacing: 40){
                
                
                VStack(alignment: .leading){
                    CustomInputField(imageName: username.isEmpty ? "person" : "person.fill", placeHolderText: "Username", text: $username)
                        .onChange(of: username, { _, newValue in
                            withAnimation {
                                let trimmedValue = newValue.trimmingCharacters(in: .whitespaces)
                                if trimmedValue.isEmpty{
                                    showUserRequired = true
                                }
                                else{
                                    showUserRequired = false
                                }
                            }
                        })
                        
                        

                    if(showUserRequired){
                        Text("Username is required!")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "4194B3"))
                            .bold()
                    }
                }
                    
                VStack(alignment: .leading){
                    CustomInputField(imageName: password.isEmpty ? "lock" : "lock.fill", placeHolderText: "Password", text: $password, isSecureField: true)
                        .onChange(of: password, { _, newValue in
                            let trimmedValue = newValue.trimmingCharacters(in: .whitespaces)
                            withAnimation {
                                if trimmedValue.isEmpty{
                                    showPasswordRequired = true
                                }
                                else{
                                    showPasswordRequired = false
                                }
                            }
                        })
                    if showPasswordRequired{
                        Text("Password is required!")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "4194B3"))
                            .bold()
                    }
                }
                
                
                
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            
            HStack{
                Spacer()
                
                NavigationLink{
                    Text("Reset password view...")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "A29475"))
                        .padding(.top)
                        .padding(.trailing, 24)
                }

            }
            
            Button {
                closeKeyboard()
                Haptics.shared.play(.soft)
                let trimmedUsername = username.trimmingCharacters(in: .whitespaces)
                let trimmedPassword = password.trimmingCharacters(in: .whitespaces)
                
                if trimmedPassword.isEmpty && trimmedUsername.isEmpty{
                    withAnimation {
                        showUserRequired = true
                        showPasswordRequired = true
                    }
                }
                
                if trimmedUsername.isEmpty{
                    withAnimation {
                        showUserRequired = true
                    }
                    
                }
                else if trimmedPassword.isEmpty
                {
                    withAnimation {
                        showPasswordRequired = true
                    }
                }
                else{
                    viewModel.login(withUsername: username, password: password)
                }
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(hex: "A29475"))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
            .disableWithOpacity(
                username.trimmingCharacters(in: .whitespaces).isEmpty ||
                password.trimmingCharacters(in: .whitespaces).isEmpty
            )
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
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
    LoginView()
}
