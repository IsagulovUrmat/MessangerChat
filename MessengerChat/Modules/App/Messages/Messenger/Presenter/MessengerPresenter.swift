//
//  MessengerPresenter.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import UIKit
import MessageKit

protocol MessengerPresenterProtocol: AnyObject {
    var title: String { get set}
    var selfSender: Sender { get set }
    var messages: [Message] { get set }
    func sendMessage(message: Message)
}

class MessengerPresenter: MessengerPresenterProtocol {
    
    var messages: [Message]
    weak var view: MessengerViewProtocol?
    private var convoID: String?
    var title: String
    private var otherId: String
    private let messageSendManager = MessageSendManager()
    private let getMessageManager = GetMessageManager()
    
    var selfSender: Sender
    private lazy var otherSender = Sender(senderId: otherId, displayName: title)
    
    init(view: MessengerViewProtocol?, convoID: String?, otherUserId: String, name: String) {
        self.view = view
        self.convoID = convoID
        self.title = name
        self.otherId = otherUserId
        self.messages = []
        self.selfSender = Sender(senderId: (FirebaseManager.shared.getUser()?.uid)!, displayName: UserDefaults.standard.string(forKey: "selfName") ?? "")
        
        if convoID != nil {
            getMessages(convoId: convoID!)
            getMessageManager.loadOneMessage(onvoId: convoID!) { [weak self] message in
                guard let self = self else { return }
                self.messages.append(message)
                view?.reloadCollection()
            }
        }
        
        
    }
    
    func sendMessage(message: Message) {
        switch message.kind {
        case .text(let text):
            messageSendManager.sendMessage(convoId: convoID, message: text, otherUser: otherSender) { [weak self] convoId in
                guard let self = self else { return }
                guard let convoID else { return }
                
                self.convoID = convoID
            }
        default:
            break
        }
    }
    
    func getMessages(convoId: String) {
        getMessageManager.getAllMessages(convoId: convoId) { [weak self] message in
            guard let self = self else { return }
            
            self.messages = message
            self.view?.reloadCollection()
        }
    }
    
}




