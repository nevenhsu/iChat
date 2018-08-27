//
//  WelcomeVC.swift
//  chat
//
//  Created by Neven on 2018/8/12.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
    }
    
    @IBAction func backgroundPressed(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    //MARK: Helper
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextField() {
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    
}
