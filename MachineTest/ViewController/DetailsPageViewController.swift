//
//  DetailsPageViewController.swift
//  MachineTest
//
//  Created by Chandrapandian Jeyaraman on 2021-02-04.
//  Copyright © 2021 Chandrapandian Jeyaraman. All rights reserved.
//

import UIKit

class DetailsPageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var usereMail: UILabel!
    
    var userDetails: Users?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User Details"
        self.updateUI()

        
    }
    
    func updateUI(){
        //Update the UI with user details
        if let userInfo = userDetails {
            self.userFullName.text = userInfo.fullName
            self.userId.text = "Id - " + String(userInfo.id)
            self.usereMail.text = userInfo.email
            if let imageData = userInfo.userImage  {
                self.userImageView.image = UIImage(data: imageData)
            }
            userImageView.layer.masksToBounds = true
            userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
