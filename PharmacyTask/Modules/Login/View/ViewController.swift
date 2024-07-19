//
//  ViewController.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    private var loginViewModel : LoginViewModel?
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let username = userNameTxtField.text, !username.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty else {
            showAlert(message: "Username or Password is empty")
            return
        }
        
        loginViewModel?.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success:
                print("Login Successful")
                if let accessToken = self?.loginViewModel?.accessToken {
                    print("Access Token: \(accessToken)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let itemsViewController = storyboard.instantiateViewController(withIdentifier: "ReturnRequestViewController") as? ReturnRequestViewController {
                        self?.navigationController?.pushViewController(itemsViewController, animated: true)
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
                self?.showAlert(message: "Login failed: \(error.localizedDescription)")
            }
        }
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginViewModel = LoginViewModel()
    }
}

