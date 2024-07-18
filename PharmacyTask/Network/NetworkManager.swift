//
//  NetworkManager.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Codable>(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


