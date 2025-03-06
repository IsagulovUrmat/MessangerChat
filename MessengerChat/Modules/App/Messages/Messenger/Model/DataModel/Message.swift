//
//  Message.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import UIKit
import MessageKit
import Firebase

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    static func mockData() -> [Message] {
        [
            Message(sender: Sender(senderId: "1", displayName: "Urmat"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-1), kind: .text("Hello! How are you? What are you doing? WIll you come here when you finish your job?")),
            
            Message(sender: Sender(senderId: "2", displayName: "User"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-3600), kind: .text("Hello! How are you? What are you doing? WIll you come here when you finish your job?")),
            
            Message(sender: Sender(senderId: "1", displayName: "Urmat"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-7200), kind: .text("Hello! How are you? What are you doing? WIll you come here when you finish your job?")),
            
            Message(sender: Sender(senderId: "2", displayName: "User"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-8000), kind: .text("Hello! How are you? What are you doing? WIll you come here when you finish your job?")),
        ]
    }
    
    init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
    }
    
    init(messageId: String, data: [String: Any]) {
        self.messageId = messageId
        self.sender = Sender(senderId: data["senderId"] as? String ?? "", displayName: "")
        self.kind = .text(data["message"] as? String ?? "")
        self.sentDate = {
            let timestamp = data["date"] as? Timestamp
            return timestamp?.dateValue() ?? Date()
        }()
    }
}
