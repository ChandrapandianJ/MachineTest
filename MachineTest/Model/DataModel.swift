//
//  DataModel.swift
//  MachineTest
//
//  Created by Chandrapandian Jeyaraman on 2021-02-04.
//  Copyright © 2021 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation

struct DataModel: Codable {
    var page: Int?
    var per_page : Int?
    var total: Int?
    var total_pages: Int?
    var data: [UserInfo]?
    var support: Others?
    
    
}

struct UserInfo: Codable {
    var id: Int?
    var email: String?
    var first_name: String?
    var last_name: String?
    var avatar: String?
}

struct Others: Codable {
    var  url: String?
    var text: String?
}
