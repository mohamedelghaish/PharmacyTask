//
//  ItemsViewController.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit
import Alamofire

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = []
    let pharmacyId = 200
    //let returnRequestId = 950

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchItems()
    }
    
    func fetchItems() {
        guard let returnRequestId = UserDefaults.standard.string(forKey: "returnRequestId") else {
            print("No access token found")
            return
        }
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items"
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No access token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self.items = try decoder.decode([Item].self, from: data)
                    self.tableView.reloadData()
                } catch {
                    print("Error decoding items: \(error)")
                }
            case .failure(let error):
                print("Error fetching items: \(error)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        cell.updateButton.tag = indexPath.row
        cell.updateButton.addTarget(self, action: #selector(promptUpdateItem(_:)), for: .touchUpInside)
        
        cell.itemCellView.layer.cornerRadius = 10.0
        cell.itemCellView.layer.borderWidth = 1.5
        cell.itemCellView.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    
    
    
    @objc func promptUpdateItem(_ sender: UIButton) {
        let item = items[sender.tag]
        
        let alertController = UIAlertController(title: "Update Item", message: "Enter new description", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Description"
            textField.text = item.description
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            if let description = alertController.textFields?.first?.text, !description.isEmpty {
                self.updateItem(item: item, newDescription: description)
            }
        }
        alertController.addAction(updateAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateItem(item: Item, newDescription: String) {
        guard let returnRequestId = UserDefaults.standard.string(forKey: "returnRequestId") else {
            print("No access token found")
            return
        }
        let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items/\(item.id)"
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No access token found")
            return
        }
        
        var updatedItem = item
        updatedItem.description = newDescription
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        do {
            let encoder = JSONEncoder()
            let parameters = try encoder.encode(updatedItem)
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "PUT"
            request.allHTTPHeaderFields = headers
            request.httpBody = parameters
            
            Alamofire.request(request).responseJSON { response in
                switch response.result {
                case .success:
                    print("Item updated successfully")
                    self.fetchItems()
                case .failure(let error):
                    print("Error updating item: \(error)")
                }
            }
        } catch {
            print("Error encoding item: \(error)")
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 290
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            deleteItemFromServer(item: item) {
                DispatchQueue.main.async {
                    self.items.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }

    
    func deleteItemFromServer(item: Item, completion: @escaping () -> Void) {
        guard let returnRequestId = UserDefaults.standard.string(forKey: "returnRequestId") else {
            print("No access token found")
            return
        }
            let url = "https://portal-test.rxmaxreturns.com/rxmax/pharmacies/\(pharmacyId)/returnrequests/\(returnRequestId)/items/\(item.id)"
            
            guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
                print("No access token found")
                return
            }
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            Alamofire.request(url, method: .delete, headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    print("Item deleted successfully")
                    completion()
                case .failure(let error):
                    print("Error deleting item: \(error)")
                }
            }
        }
}
