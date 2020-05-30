//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 29.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }
}

