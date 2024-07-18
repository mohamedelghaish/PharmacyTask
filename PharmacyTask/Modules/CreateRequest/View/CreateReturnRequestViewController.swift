//
//  CreateReturnRequestViewController.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit
import Alamofire

struct Wholesaler: Codable {
    let id: Int
    let name: String
}

import UIKit

class CreateReturnRequestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var serviceTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var wholesalerPickerView: UIPickerView!
    
    private let viewModel = CreateReturnRequestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wholesalerPickerView.dataSource = self
        wholesalerPickerView.delegate = self
        
        setupViewModel()
        viewModel.fetchWholesalers()
    }
    
    private func setupViewModel() {
        viewModel.onWholesalersFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.wholesalerPickerView.reloadAllComponents()
            }
        }
        
        viewModel.onWholesalersFetchFailed = { error in
            print("Error fetching wholesalers: \(error)")
        }
        
        viewModel.onReturnRequestCreated = { [weak self] in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let itemsViewController = storyboard.instantiateViewController(withIdentifier: "AddItemScreen") as? AddItemViewController {
                    self?.navigationController?.pushViewController(itemsViewController, animated: true)
                }
            }
        }
        
        viewModel.onReturnRequestCreationFailed = { error in
            print("Error creating return request: \(error)")
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let selectedServiceTypeIndex = serviceTypeSegmentedControl.selectedSegmentIndex
        let serviceType = selectedServiceTypeIndex == 0 ? "EXPRESS_SERVICE" : "FULL_SERVICE"
        let selectedWholesalerIndex = wholesalerPickerView.selectedRow(inComponent: 0)
        let wholesalerId = viewModel.wholesalers[selectedWholesalerIndex].id
        
        viewModel.createReturnRequest(serviceType: serviceType, wholesalerId: wholesalerId)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.wholesalers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.wholesalers[row].name
    }
}
