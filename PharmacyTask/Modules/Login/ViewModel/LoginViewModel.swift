//
//  LoginViewModel.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation

class LoginViewModel {
    
    var accessToken: String?
    
    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://portal-test.rxmaxreturns.com/rxmax/auth"
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        NetworkManager.shared.request(url: url, method: .post, parameters: parameters, headers: nil) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let response):
                self.accessToken = response.token
                UserDefaults.standard.set(response.token, forKey: "accessToken")
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct LoginResponse: Codable {
    let token: String
}
