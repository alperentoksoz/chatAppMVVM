//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 28.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
    
    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh: mn a"
        return dateFormatter.string(from: date)
    }
}
