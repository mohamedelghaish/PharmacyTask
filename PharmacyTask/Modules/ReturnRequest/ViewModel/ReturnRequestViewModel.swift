
//
//  ReturnRequestViewModel.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import Foundation
import Alamofire

class ReturnRequestViewModel {
    
    var returnRequests: [ReturnRequestContent] = []
    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((Error) -> Void)?
    
    func fetchReturnRequests() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No access token found")
            return
        }
        
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/200/returnrequests"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        NetworkManager.shared.request(url: url, method: .get, parameters: nil, headers: headers) { (result: Swift.Result<ReturnRequestResponse, Error>) in
            switch result {
            case .success(let response):
                self.returnRequests = response.content
                self.onFetchCompleted?()
            case .failure(let error):
                self.onFetchFailed?(error)
            }
        }
    }
}
