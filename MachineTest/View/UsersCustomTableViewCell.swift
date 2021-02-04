//
//  UsersCustomTableViewCell.swift
//  MachineTest
//
//  Created by Chandrapandian Jeyaraman on 2021-02-04.
//  Copyright © 2021 Chandrapandian Jeyaraman. All rights reserved.
//

import UIKit

class UsersCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userEmailId: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCellWithData(data: Users) {
        
        self.userId.text = String(data.id)
        self.userFullName.text = data.fullName ?? ""
        self.userEmailId.text = data.email ?? ""
        
        //image
        if let imageData = data.userImage  {
            self.userImageView.image = UIImage(data: imageData)
        }
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
    }
}
