//
//  MessageListManager.swift
//  MessengerChat
//
//  Created by sunflow on 5/3/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class MessageListManager {
    
    func getChatList(completion: @escaping ([ChatItem]) -> Void) {
        guard let uid = FirebaseManager.shared.getUser()?.uid else { return }
        
        Firestore.firestore()
            .collection(.users)
            .document(uid)
            .collection(.conversation)
            .order(by: "date", descending: true)
            .addSnapshotListener { snap, error in
                guard error == nil else { return }
                
                guard let doc = snap?.documents else { return }
                var chatItems: [ChatItem] = []
                doc.forEach {
                    let chatItem = ChatItem(convoId: $0.documentID, data: $0.data())
                    chatItems.append(chatItem)
                }
                completion(chatItems)
            }
    }
    
}
