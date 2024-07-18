//
//  ReturnRequestViewController.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit

class ReturnRequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func createReturnRequestBtn(_ sender: Any) {
        
    }
    
    @IBOutlet weak var returnRequestTableView: UITableView!
    private let viewModel = ReturnRequestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnRequestTableView.dataSource = self
        returnRequestTableView.delegate = self
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchReturnRequests()
    }
    
    private func setupViewModel() {
        viewModel.onFetchCompleted = { [weak self] in
            DispatchQueue.main.async {
                self?.returnRequestTableView.reloadData()
            }
        }
        
        viewModel.onFetchFailed = { error in
            print("Error: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.returnRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnRequestTableViewCell", for: indexPath) as! ReturnRequestTableViewCell
        let returnRequestContent = viewModel.returnRequests[indexPath.row]
        let returnRequest = returnRequestContent.returnRequest
        cell.idLabel.text = "ID: \(returnRequest.id)"
        cell.createdAtLabel.text = "Created At: \(Date(timeIntervalSince1970: returnRequest.createdAt / 1000))"
        cell.numOfItemsLabel.text = "Number of Items: \(returnRequestContent.numberOfItems)"
        cell.statusLabel.text = "Status: \(returnRequest.returnRequestStatusLabel)"
        cell.serviceTypeLabel.text = "Service Type: \(returnRequest.serviceType)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}
