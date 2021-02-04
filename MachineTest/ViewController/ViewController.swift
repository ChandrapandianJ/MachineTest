//
//  ViewController.swift
//  MachineTest
//
//  Created by Chandrapandian Jeyaraman on 2021-02-04.
//  Copyright © 2021 Chandrapandian Jeyaraman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userListTableView: UITableView!
    
    static let urlString = "https://reqres.in/api/users?page=1"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var usersListArray: [Users] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Check the data from DB
        let userInfo = fetchUserList()
        if userInfo.count > 0 {
            usersListArray = userInfo
        } else {
            //If DB doesn't have data load API to get the data
            self.activityIndicator.startAnimating()
            callAPI()
        }
    }

    func callAPI () {
        let url = URL(string: ViewController.urlString)!
        ServiceManager.loadDataFrom(url: url) { (userList) in
            guard let usersInfo = userList else {
                return
            }
            DispatchQueue.main.async {
                for user in usersInfo {
                    //Save the data to DB once we got the user data
                    self.saveUserInfo(info: user)
                }
            }
        }
    }
    
    
    func saveUserInfo(info: UserInfo) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        // Download user image and store it into DB as Data
        ServiceManager.downloadImageFromUrl(ImageURL: info.avatar ?? "") { (imageData) in
            do {
                newUser.setValue(info.id, forKey: "id")
                let fullName = info.first_name! + " " + info.last_name!
                newUser.setValue(fullName, forKey: "fullName")
                newUser.setValue(info.email, forKey: "email")
                newUser.setValue(imageData, forKey: "userImage")
                //Save
                try context.save()
                self.usersListArray = self.fetchUserList()
                DispatchQueue.main.async {
                    // update the UI once complete the API call
                    self.userListTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            } catch {
                print("Failed saving")
            }
        }

    }
    
    
    func fetchUserList() -> [Users] {
        //Fetch the data from DB
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
        // Sort the user list by user Id
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
            return []
        }
    }
    
    
}

// TableView Delegate and DataSource
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersListArray.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListCustomCellIdentifier", for: indexPath) as! UsersCustomTableViewCell
        let user = usersListArray[indexPath.row]
        // Configure user data
        cell.configureCellWithData(data: user)
        
        return cell
    }
    
    
    //On select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsPageViewControllerId") as? DetailsPageViewController {
            let user = usersListArray[indexPath.row]
            viewController.userDetails = user
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
}
