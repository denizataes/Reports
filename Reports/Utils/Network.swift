import UIKit
import Alamofire

class Network {
    static let shared = Network()
    
    private init() { }

    func ping(url: String, completion: @escaping (Bool) -> Void) {
        AF.request(url, method: .head, requestModifier:  { $0.timeoutInterval = 3 }).validate().response { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
