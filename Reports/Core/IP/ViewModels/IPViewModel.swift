//
//  IPViewModel.swift
//  Reports
//
//  Created by Deniz Ata Eş on 12.11.2023.
//

import Foundation
import SwiftUI

class IPViewModel: ObservableObject{
    @Published var userEnteredURL: String = ""
    @Published var isMainScreenVisible: Bool = false
    @Published var isMultiplyVisible: Bool = false
    @Published var loading: Bool = false
    
    //MARK: Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func checkkAndloginIP(){
        withAnimation {
            if !userEnteredURL.isEmpty{
                loading = true
                
                Network.shared.ping(url: "http://" + userEnteredURL) { [weak self] result in
                    guard let strongSelf = self else{return}
                    strongSelf.loading = false
                    if result{
                        
                        DispatchQueue.main.async {
                            Statics.baseURL = strongSelf.userEnteredURL
                            strongSelf.isMainScreenVisible = true
                            strongSelf.isMultiplyVisible = false
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            strongSelf.showError = true
                            strongSelf.errorMessage = "The entered IP address is unreachable."
                            strongSelf.isMultiplyVisible = true
                        }
                    }
                }
            }
        }
    }
    
    func checkIP(){
        if !Statics.baseURL.isEmpty{
            Network.shared.ping(url: "http://" + Statics.baseURL) { [weak self] result in
                guard let strongSelf = self else{return}
                strongSelf.loading = false
                if result{
                    DispatchQueue.main.async {
                        strongSelf.isMainScreenVisible = true
                        strongSelf.isMultiplyVisible = false
                    }
                }
                else{
                    DispatchQueue.main.async {
                        strongSelf.showError = true
                        strongSelf.errorMessage = "The entered IP address is unreachable."
                        strongSelf.isMultiplyVisible = true
                    }
                }
            }
        }
    }
    
}
