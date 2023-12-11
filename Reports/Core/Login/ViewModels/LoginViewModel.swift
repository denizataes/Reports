import SwiftUI

class LoginViewModel: ObservableObject{
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    @Published var loading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    let service = ReportsService.shared
    
     init() {}
    
    func login(withUsername username: String, password: String)
    {
        loading = true
        self.service.makeGetRequest(
            endpoint: Statics.loginURL,
            parameters: [
                "username" : username,
                "password" : password
            ],
            responseType: User.self) { [weak self] result in
                guard let strongSelf = self else {return}
                strongSelf.loading = false
                switch(result){
                case .success(let user):
                    DispatchQueue.main.async{
                        withAnimation {
                            strongSelf.currentUser = user
                        }
                    }
                    break
                case .failure(let error):
                    strongSelf.showError = true
                    strongSelf.errorMessage = "Invalid username or password."
                }
            }
    }
    
    func signOut(){
        withAnimation {
            currentUser = nil
        }
    }
    
}
