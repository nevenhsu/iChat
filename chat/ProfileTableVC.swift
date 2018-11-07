//
//  ProfileTableVC.swift
//  chat
//
//  Created by Neven on 2018/11/2.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit

class ProfileTableVC: UITableViewController {

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneButtonOutlet: UIButton!
    @IBOutlet weak var messageButtonOutlet: UIButton!
    @IBOutlet weak var blockUserOutlet: UIButton!
    
    var user: FUser?;
    
    // MARK: IBActions
    @IBAction func phoneButtonPressed(_ sender: UIButton) {
    }
    @IBAction func messageButtonPressed(_ sender: UIButton) {
    }
    @IBAction func blockUserButtonPressed(_ sender: UIButton) {
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 30
    }
    
    // MARK: Setup UI
    
    func setupUI() {
        if user != nil {
            self.title = "Profile"
            
            fullNameLabel.text = user!.fullname
            phoneNumberLabel.text = user!.phoneNumber
            
            updateBlockStatus()
            
            imageFromData(pictureData: user!.avatar) { (image) in
                if image != nil {
                    self.avatarImage.image = image!.circleMasked
                }
            }
        }
    }
    
    func updateBlockStatus() {
        
        if user?.objectId != FUser.currentId() {
            phoneButtonOutlet.isHidden = false
            messageButtonOutlet.isHidden = false
            blockUserOutlet.isHidden = false
        } else {
            phoneButtonOutlet.isHidden = true
            messageButtonOutlet.isHidden = true
            blockUserOutlet.isHidden = true
        }
        
        if FUser.currentUser()!.blockedUsers.contains(user?.objectId) {
            blockUserOutlet.setTitle("Unblock User", for: .normal)
        } else {
            blockUserOutlet.setTitle("Block User", for: .normal)
        }
        
    }
    
    

}
