//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 26.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
