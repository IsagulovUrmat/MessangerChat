//
//  MessageListViewPresenter.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import UIKit

protocol MessageListViewPresenterProtocol: AnyObject {
    var chatList: [ChatItem] { get set }
}
class MessageListViewPresenter: MessageListViewPresenterProtocol{
    
    private let messageListManager = MessageListManager()
    weak var view: MessageListViewProtocol?
    
    var chatList: [ChatItem]
    
    init(view: MessageListViewProtocol?) {
        self.view = view
        self.chatList = []
        getChatList()
    }
    
    func getChatList() {
        messageListManager.getChatList { [weak self] chatList in
            guard let self = self else { return }
            self.chatList = chatList
            self.view?.reloadTable()
            
        }
    }
    
}
