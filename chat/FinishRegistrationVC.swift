//
//  FinishRegistrationVC.swift
//  chat
//
//  Created by Neven on 2018/8/29.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email: String!
    var password: String!
    var avatarImage: UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print(email, password)
    }

    //MARK: IBActions
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        dismissKeyboard()
        cleanTextField()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        dismissKeyboard()
        ProgressHUD.show("Registering ...")
        
        if nameTextField.text != "" && surnameTextField.text != "" && countryTextField.text != "" && cityTextField.text != "" && phoneTextField.text != "" {
            
            FUser.registerUserWith(email: email!, password: password!, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                if error != nil {
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                self.registerUser()
                
            }
            
        } else {
            ProgressHUD.showError("All fields are required!")
        }
        
        
    }
    
    //MARK: Helper
    func registerUser() {
        
        let fullName = nameTextField.text! + " " + surnameTextField.text!
        
        var tempDictionary: Dictionary = [
            kFIRSTNAME: nameTextField.text!,
            kLASTNAME: surnameTextField.text!,
            kFULLNAME: fullName,
            kCOUNTRY: countryTextField.text!,
            kCITY: cityTextField.text!,
            kPHONE: phoneTextField.text!
        ] as [String : Any]
        
        if avatarImage == nil {
            
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (imageInitials) in
                
                let avatarImg = imageInitials.jpegData(compressionQuality: 0.7)
                let avatar = avatarImg?.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0))
                
                tempDictionary[kAVATAR] = avatar
            }
        } else {
            
            let avatarImg = avatarImage!.jpegData(compressionQuality: 0.7)
            let avatar = avatarImg?.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0))
            
            tempDictionary[kAVATAR] = avatar
        }
        
        finishRegistration(withValues: tempDictionary)
        
    }
    
    func finishRegistration(withValues: [String : Any]) {
        updateCurrentUserInFirestore(withValues: withValues) { (error) in
            if error != nil {
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                }
                return
            }
            
            // Go to App
            
        }
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextField() {
        nameTextField.text = ""
        surnameTextField.text = ""
        countryTextField.text = ""
        cityTextField.text = ""
        phoneTextField.text = ""
        avatarImageView.image = nil
    }
    
}
