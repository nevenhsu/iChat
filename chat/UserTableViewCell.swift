//
//  UserTableViewCell.swift
//  chat
//
//  Created by Neven on 2018/10/20.
//  Copyright © 2018 Neven. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath)
}

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var indexPath: IndexPath!
    var delegate: UserTableViewCellDelegate?
    
    let tapGesture = UIGestureRecognizer()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGesture.addTarget(self, action: #selector(avatarTap))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGesture)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCellWith(fUser: FUser, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.fullNameLabel.text = fUser.fullname
        
        if fUser.avatar != "" {
            imageFromData(pictureData: fUser.avatar) { (image) in
                if image != nil {
                    self.avatarImage.image = image!.circleMasked
                }
            }
        }
        // self.avatarImage =
    }
    
    @objc func avatarTap() {
        delegate?.didTapAvatarImage(indexPath: indexPath)
        print("items index: \(indexPath)")
    }
    
    
}
