//
//  Service.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 27.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Firebase

class Service {
    
    static func fetchUser(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
}
