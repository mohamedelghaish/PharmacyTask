//
//  ItemsViewModel.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 19/07/2024.
//


import Foundation
import Alamofire

class ItemsViewModel {
    
    var items: [Item] = []
    
    var onItemsFetched: (() -> Void)?
    var onItemUpdated: (() -> Void)?
    var onItemDeleted: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private let pharmacyId = 200
    private let returnRequestId = 950
    
    func fetchItems() {
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items"
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            onError?("No access token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        NetworkManager.shared.request(url: url, method: .get, parameters: nil, headers: headers) { (result: Swift.Result<[Item], Error>) in
            switch result {
            case .success(let items):
                self.items = items
                self.onItemsFetched?()
            case .failure(let error):
                self.onError?("Error fetching items: \(error.localizedDescription)")
            }
        }
    }
    
    func updateItem(item: Item, newDescription: String) {
        var updatedItem = item
        updatedItem.description = newDescription
        
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items/\(item.id)"
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            onError?("No access token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "description": updatedItem.description
        ]
        
        NetworkManager.shared.request(url: url, method: .put, parameters: parameters, headers: headers) { (result: Swift.Result<Item, Error>) in
            switch result {
            case .success:
                self.onItemUpdated?()
            case .failure(let error):
                self.onError?("Error updating item: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteItem(item: Item) {
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items/\(item.id)"
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            onError?("No access token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        NetworkManager.shared.request(url: url, method: .delete, parameters: nil, headers: headers) { (result: Swift.Result<Item, Error>) in
            switch result {
            case .success:
                self.onItemDeleted?()
            case .failure(let error):
                self.onError?("Error deleting item: \(error.localizedDescription)")
            }
        }
    }
}
