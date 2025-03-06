//
//  MessageListView.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import UIKit

protocol MessageListViewProtocol: AnyObject {
    func reloadTable()
}

class MessageListView: UIViewController, MessageListViewProtocol {
    
    var presenter: MessageListViewPresenterProtocol!
    
    private lazy var tableView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: view.bounds, style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .localize("tabMessages")
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
    }
}

extension MessageListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let chatItem = presenter.chatList[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = chatItem.name
        config.image = UIImage(systemName: "person.fill")
        config.secondaryText = chatItem.lastMessage?.truncate(to: 80)
        
        cell.contentConfiguration = config
        
        return cell
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    
}

extension MessageListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatItem = presenter.chatList[indexPath.row]
        
        let messengerController = Builder.getMessangerView(chatItem: chatItem)
        
        messengerController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(messengerController, animated: true)
    }
}
