//
//  AddItemViewController.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var ndcTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var fullQuantityTextField: UITextField!
    @IBOutlet weak var partialQuantityTextField: UITextField!
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var lotNumberTextField: UITextField!
    
    private var viewModel = AddItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(message: "Item added successfully.")
                self?.clearForm()
            }
        }
        
        viewModel.onFailure = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(message: "Failed to add item. Please try again.")
            }
        }
    }

    @IBAction func addItemButtonTapped(_ sender: UIButton) {
        guard let ndc = ndcTextField.text, !ndc.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let manufacturer = manufacturerTextField.text, !manufacturer.isEmpty,
              let fullQuantity = fullQuantityTextField.text, !fullQuantity.isEmpty,
              let partialQuantity = partialQuantityTextField.text, !partialQuantity.isEmpty,
              let expirationDate = expirationDateTextField.text, !expirationDate.isEmpty,
              let lotNumber = lotNumberTextField.text, !lotNumber.isEmpty else {
            
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        viewModel.addItem(ndc: ndc, description: description, manufacturer: manufacturer, fullQuantity: fullQuantity, partialQuantity: partialQuantity, expirationDate: expirationDate, lotNumber: lotNumber)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let itemsViewController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController {
            self.navigationController?.pushViewController(itemsViewController, animated: true)
        }
    }
    
    func clearForm() {
        ndcTextField.text = ""
        descriptionTextField.text = ""
        manufacturerTextField.text = ""
        fullQuantityTextField.text = ""
        partialQuantityTextField.text = ""
        expirationDateTextField.text = ""
        lotNumberTextField.text = ""
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
