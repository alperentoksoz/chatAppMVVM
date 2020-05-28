//
//  User.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 27.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let fullname: String
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
