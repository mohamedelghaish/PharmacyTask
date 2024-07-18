//
//  AddItemViewModel.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 19/07/2024.
//

import Foundation
import Alamofire

class AddItemViewModel {
    
    var onSuccess: (() -> Void)?
    var onFailure: ((Error) -> Void)?
    
    func addItem(ndc: String, description: String, manufacturer: String, fullQuantity: String, partialQuantity: String, expirationDate: String, lotNumber: String) {
        
        let parameters: [String: Any] = [
            "ndc": ndc,
            "description": description,
            "manufacturer": manufacturer,
            "packageSize": "200",
            "requestType": "csc",
            "name": "Best Item Name",
            "strength": "strong",
            "dosage": "alssot",
            "fullQuantity": fullQuantity,
            "partialQuantity": partialQuantity,
            "expirationDate": expirationDate,
            "status": "PENDING",
            "lotNumber": lotNumber
        ]
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No access token found")
            return
        }
        
        guard let returnRequestId = UserDefaults.standard.string(forKey: "returnRequestId") else {
            print("No access token found")
            return
        }
        
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/200/returnrequests/\(returnRequestId)/items"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        NetworkManager.shared.request(url: url, method: .post, parameters: parameters, headers: headers) { (result: Swift.Result<Item, Error>) in
            switch result {
            case .success:
                self.onSuccess?()
            case .failure(let error):
                self.onFailure?(error)
            }
        }
    }
}
