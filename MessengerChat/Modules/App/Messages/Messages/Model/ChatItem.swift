//
//  ChatItem.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import Foundation
import Firebase

struct ChatItem {
    var convoId: String?
    
    var name: String
    var otherUserID: String
    
    var date: Date
    var lastMessage: String?
    
    init(convoId: String?, name: String, otherUserID: String, date: Date, lastMessage: String?) {
        self.convoId = convoId
        self.name = name
        self.otherUserID = otherUserID
        self.date = date
        self.lastMessage = lastMessage
    }
 
    init(convoId: String, data: [String: Any]) {
        self.convoId = convoId
        self.name = data["name"] as? String ?? ""
        self.otherUserID = data["otherId"] as? String ?? ""
        self.date = {
            let timeStamp = data["date"] as? Timestamp
            return timeStamp?.dateValue() ?? Date()
        }()
        self.lastMessage = data["lastMessage"] as? String ?? ""
    }
}
