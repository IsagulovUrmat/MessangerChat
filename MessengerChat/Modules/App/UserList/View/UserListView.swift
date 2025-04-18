//
//  UserListView.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import UIKit

protocol UserListViewProtocol: AnyObject {
    func reloadTable()
}

class UserListView: UIViewController, UserListViewProtocol {
    
    var presenter: UserListViewPresenterProtocol!
    
    lazy var signOutButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(signOut))
    
    
    private lazy var tableView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: view.bounds, style: .insetGrouped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = .localize("tabUsers")
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = signOutButton
    }
    
    @objc func signOut() {
        FirebaseManager.shared.signOut()
    }
}

extension UserListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cellItem = presenter.users[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = cellItem.name
        config.image = UIImage(systemName: "person.circle.fill")
        
        cell.contentConfiguration = config
        
        return cell
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    
}

extension UserListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(presenter.users[indexPath.row].name)
        
        let chatItem = ChatItem(convoId: nil, name: presenter.users[indexPath.row].name, otherUserID: presenter.users[indexPath.row].id, date: Date(), lastMessage: nil)
        
        let messanger = Builder.getMessangerView(chatItem: chatItem)
        
        navigationController?.pushViewController(messanger, animated: true)
       
    }
}
