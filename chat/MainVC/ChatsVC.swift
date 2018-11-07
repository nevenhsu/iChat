//
//  ChatsVC.swift
//  chat
//
//  Created by Neven on 2018/10/22.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit

class ChatsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: IBAction
    @IBAction func createNewChatButtonPressed(_ sender: Any) {
        
        let userVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userTableView") as! UserTableVC
        self.navigationController?.pushViewController(userVC, animated: true)
    
    }
    

}
