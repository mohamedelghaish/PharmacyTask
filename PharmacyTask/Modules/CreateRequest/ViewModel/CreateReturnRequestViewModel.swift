//
//  CreateReturnRequestViewModel.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation
import Alamofire

class CreateReturnRequestViewModel {
    
    var wholesalers: [Wholesaler] = []
    var onWholesalersFetched: (() -> Void)?
    var onWholesalersFetchFailed: ((Error) -> Void)?
    var onReturnRequestCreated: (() -> Void)?
    var onReturnRequestCreationFailed: ((Error) -> Void)?
    
    func fetchWholesalers() {
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/200/wholesalers"
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No access token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        NetworkManager.shared.request(url: url, method: .get, parameters: nil, headers: headers) { (result: Swift.Result<[Wholesaler], Error>) in
            switch result {
            case .success(let wholesalers):
                self.wholesalers = wholesalers
                self.onWholesalersFetched?()
            case .failure(let error):
                self.onWholesalersFetchFailed?(error)
            }
        }
    }
    
    func createReturnRequest(serviceType: String, wholesalerId: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No access token found")
            return
        }
        
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/200/returnrequests"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "serviceType": serviceType,
            "wholesalerId": wholesalerId
        ]
        
        NetworkManager.shared.request(url: url, method: .post, parameters: parameters, headers: headers) { (result: Swift.Result<CreateReturnRequestResponse, Error>) in
            switch result {
            case .success(let response):
                print("Create Return Request Successful: \(response)")
                UserDefaults.standard.set(response.id, forKey: "returnRequestId")
                self.onReturnRequestCreated?()
            case .failure(let error):
                print("Error creating return request: \(error)")
                self.onReturnRequestCreationFailed?(error)
            }
        }
    }


}


