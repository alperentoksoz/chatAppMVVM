//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 26.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

struct RegistrationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
}
