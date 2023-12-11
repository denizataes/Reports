//
//  ReportsService.swift
//  Reports
//
//  Created by Deniz Ata Eş on 11.11.2023.
//

import Foundation
import Alamofire
class ReportsService{
    
    static let shared = ReportsService()

    func makeGetRequest<T: Decodable>(endpoint: String, parameters: [String: Any]?, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint, parameters: parameters)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
