//
//  ConversationsController.swift
//  ChatApp
//
//  Created by Alperen Toksöz on 25.05.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationsCell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    private var users = [User]()
    
    private var conversations = [Conversation]()
    private var conversationDictionary = [String: Conversation]()

    
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.setDimensions(width: 56, height: 56)
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(withTitle: Auth.auth().currentUser?.email ?? "", prefersLargeTitles: true)
    }
    
    // MARK: - Selectors
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true,completion: nil)
    }
    
    @objc func showProfile() {
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true,completion: nil)
    }
    
    // MARK: API
    
    func fetchConversations() {
        showLoader(true)
        Service.fetchConversations { (conversations) in
            conversations.forEach { (conversation) in
                let message = conversation.message
                self.conversationDictionary[message.chartPartnerId] = conversation
            }
            
            self.showLoader(false)
            
            self.conversations = Array(self.conversationDictionary.values)
            self.tableView.reloadData()
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav,animated: true,completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white

        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

    // MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationsCell
        
        cell.conversation = conversations[indexPath.row]
        
        return cell
    }
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller,animated: true)
    }
    
}

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantstoStartChatWith user: User) {
        print("DEBUG: Here is ConversationController at conform protocol \(user.username)")
        dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)
        navigationController?.pushViewController(chat,animated: true)
    }
    
}

// MARK: - ProfileControllerDelegate

extension ConversationsController: ProfileControllerDelegate {
    func handleLogout() {
        print("DEBUG : ConversationsController: ProfileControllerDelegate HandleLogout")
        logout()
    }

}

// MARK: - AuthenticationDelegate

extension ConversationsController: AuthenticationDelegate {
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
        print("DEBUG :Here extension ConversationsController: AuthenticationDelegate  ")
        configureUI()
        fetchConversations()
    }

}
