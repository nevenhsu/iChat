//
//  FinishRegistrationVC.swift
//  chat
//
//  Created by Neven on 2018/8/29.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit

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

        // Do any additional setup after loading the view.
    }

    //MARK: IBActions
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
    }
    
    
    
}
