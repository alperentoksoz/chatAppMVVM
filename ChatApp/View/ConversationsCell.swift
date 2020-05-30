//
//  ConversationsCell.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 28.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit


class ConversationsCell: UITableViewCell {
    
    // MARK: - Properties
    
    var conversation: Conversation? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "alperentoksoz"
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14 )
        label.text = "Merhaba ben ayşe test ediyorum"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel,messageLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configure() {
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)
        
        usernameLabel.text = conversation.user.username
        messageLabel.text = conversation.message.text
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        
    }
}
