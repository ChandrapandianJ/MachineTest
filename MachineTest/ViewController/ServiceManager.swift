//
//  ServiceManager.swift
//  MachineTest
//
//  Created by Chandrapandian Jeyaraman on 2021-02-04.
//  Copyright © 2021 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation

class ServiceManager {
    
    class func loadDataFrom(url: URL, completionHandler: @escaping (([UserInfo]?)->Void)) {
        //Service call
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let responseData = data {
                do {
                    let user = try JSONDecoder().decode(DataModel.self, from: responseData)
                    let userList = user.data
                    completionHandler(userList)
                } catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    
    class func downloadImageFromUrl(ImageURL :String, completionHandler: @escaping ((Data)->Void)) {
        //Image Download
        URLSession.shared.dataTask( with: URL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            if let imageData = data {
                completionHandler(imageData)
            }
        }).resume()
    }
}
