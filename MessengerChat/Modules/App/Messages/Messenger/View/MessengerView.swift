//
//  MessengerView.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import UIKit
import MessageKit
import InputBarAccessoryView

protocol MessengerViewProtocol: AnyObject {
    func reloadCollection()
}

class MessengerView: MessagesViewController, MessengerViewProtocol {
    
    var presenter: MessengerPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = presenter.title
        showMessageTimestampOnSwipeLeft = true
        messangerSetup()
        messagesCollectionView.reloadDataAndKeepOffset()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        messagesCollectionView.scrollToLastItem(animated: true)
    }
    
    private func messangerSetup() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
    }
    
    private func insertMessage(_ message: Message) {
        presenter.messages.append(message)
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([presenter.messages.count - 1])
            if presenter.messages.count >= 2 {
                messagesCollectionView.reloadSections([presenter.messages.count - 2])
            }
        }) { [weak self] _ in
            self?.messagesCollectionView.scrollToLastItem(animated: true)
        }
    }
    
    func reloadCollection() {
        messagesCollectionView.reloadDataAndKeepOffset()
    }
    
}

extension MessengerView: MessagesDataSource {
    var currentSender: SenderType {
        presenter.selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageType {
        presenter.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        presenter.messages.count
    }
    
    
}

extension MessengerView: MessagesDisplayDelegate, MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        20
    }
    
    func messageTopLabelHeight(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        20
    }
    
    func messageBottomLabelHeight(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        20
    }
    
    func backgroundColor(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        message.sender.senderId == presenter.selfSender.senderId ? .systemBlue : .systemFill
    }
    
    func messageTopLabelAttributedText(for message: any MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                             NSAttributedString.Key.foregroundColor: UIColor.black
                                                            ])
    }
    
    func messageBottomLabelAttributedText(for message: any MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let formattedTime = message.sentDate.formatted(.dateTime.hour().minute())

        return NSAttributedString(string: formattedTime, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                             NSAttributedString.Key.foregroundColor: UIColor.black
                                                            ])
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.initials = String(message.sender.displayName.first ?? "A")
        avatarView.backgroundColor = .systemCyan
        
    }
}


extension MessengerView: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let message = Message(sender: presenter.selfSender, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text))
        
        self.insertMessage(message)
        self.presenter.sendMessage(message: message)
        inputBar.inputTextView.text = ""
        
    }
}
