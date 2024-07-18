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
            print("Username or Password is empty")
            return
        }
        
        loginViewModel?.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success:
                print("Login Successful")
                if let accessToken = self?.loginViewModel?.accessToken {
                    print("Access Token: \(accessToken)")
                    
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginViewModel = LoginViewModel()
    }
}

