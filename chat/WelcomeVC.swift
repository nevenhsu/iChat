//
//  WelcomeVC.swift
//  chat
//
//  Created by Neven on 2018/8/12.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit
import ProgressHUD


class WelcomeVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //MARK: IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            loginUser()
        } else {
            ProgressHUD.showError("Email and Password is missing!")
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" {
            
            if passwordTextField.text != repeatPasswordTextField.text {
                ProgressHUD.showError("Password dont match!")
                return
            }
            
            registerUser()
        } else {
            ProgressHUD.showError("All fields are required!")
        }
    }
    
    @IBAction func backgroundPressed(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    
    //MARK: Helper
    func loginUser() {
        ProgressHUD.show("Login...")
        
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            self.goApp()
        }
    }
    
    func registerUser() {
        
    }
    
    func goApp() {
        ProgressHUD.dismiss()
        cleanTextField()
        dismissKeyboard()
        
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextField() {
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    
}
