//
//  MessageSendManager.swift
//  MessengerChat
//
//  Created by sunflow on 3/3/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class MessageSendManager {
    
    func sendMessage(convoId: String?, message: String, otherUser: Sender, completion: @escaping (String?) -> Void) {
        guard let selfId = FirebaseManager.shared.getUser()?.uid else { return }
        
        if convoId == nil {
            self.createNewConvo(uid: selfId, message: message, otherUser: otherUser) { convoId in
                completion(convoId)
            }
        } else {
            self.setMessage(uid: selfId, convoId: convoId!, message: message, otherUser: otherUser)
        }
    }
    
    private func createNewConvo(uid: String, message: String, otherUser: Sender, completion: (String) -> Void) {
        let convoId = UUID().uuidString
        let convoData: [String: Any] = [
            "date": Date(),
            "senderId": uid,
            "otherId": otherUser.senderId,
            "users": [uid, otherUser.senderId]
        ]
        
        Firestore.firestore().collection(.conversation)
            .document(convoId)
            .setData(convoData, merge: true)
        
        setMessage(uid: uid, convoId: convoId, message: message, otherUser: otherUser)
        completion(convoId)
    }
    
    private func setMessage(uid: String, convoId: String, message: String, otherUser: Sender) {
        
        let messageData: [String: Any] = [
            "date": Date(),
            "message": message,
            "senderId": uid,
            "otherId": otherUser.senderId
        ]
        
        Firestore.firestore()
            .collection(.conversation)
            .document(convoId)
            .collection(.messages)
            .document(UUID().uuidString)
            .setData(messageData)
        
        // self last message
        let selfLastMessage: [String: Any] = [
            "name": otherUser.displayName,
            "otherId": otherUser.senderId,
            "lastMessage": message,
            "date": Date()
        ]
        Firestore.firestore()
            .collection(.users)
            .document(uid)
            .collection(.conversation)
            .document(convoId)
            .setData(selfLastMessage)
        
        // other last message
        let otherUserLastMessage: [String: Any] = [
            "name": UserDefaults.standard.string(forKey: "selfName") ?? "",
            "otherId": uid,
            "lastMessage": message,
            "date": Date(),
        ]
        Firestore.firestore()
            .collection(.users)
            .document(otherUser.senderId)
            .collection(.conversation)
            .document(convoId)
            .setData(otherUserLastMessage)
            
    }
    
    
}
       
            
