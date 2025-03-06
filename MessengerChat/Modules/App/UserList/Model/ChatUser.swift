//
//  User.swift
//  MessengerChat
//
//  Created by sunflow on 1/3/25.
//

import Foundation

struct ChatUser {
    var id: String
    var name: String
    
    init(uid:String, userInfo: [String: Any]) {
        self.id = uid
        self.name = userInfo["name"] as? String ?? ""
    }
}
