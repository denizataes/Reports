//
//  ReportsApp.swift
//  Reports
//
//  Created by Deniz Ata Eş on 9.11.2023.
//

import SwiftUI

@main
struct ReportsApp: App {
    @StateObject private var ipViewModel = IPViewModel()
    @StateObject private var loginViewModel =  LoginViewModel()
    
    var body: some Scene {
        WindowGroup{
            if(ipViewModel.isMainScreenVisible){
                if(loginViewModel.currentUser != nil){
                    MainTabView()
                        .environmentObject(loginViewModel)
                        .environmentObject(ipViewModel)

                }
                else
                {
                    LoginView()
                        .transition(.slide)
                        .environmentObject(loginViewModel)
                        .environmentObject(ipViewModel)
                        

                }
            }
            else
            {
                IPView(viewModel: ipViewModel)
                    .environmentObject(loginViewModel)

            }
        }
    }
}
