//
//  GetMessageManager.swift
//  MessengerChat
//
//  Created by sunflow on 5/3/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class GetMessageManager {
    
    var lastSnapshot: DocumentSnapshot?
    
    func getAllMessages(convoId: String, completion: @escaping ([Message]) -> Void) {
        Firestore.firestore()
            .collection(.conversation)
            .document(convoId)
            .collection(.messages)
            .limit(to: 50)
            .order(by: "date", descending: true)
            .getDocuments { snapshot, error in
                guard error == nil else { return }
                
                guard let messagesSnap = snapshot?.documents else { return }
                
                self.lastSnapshot = messagesSnap.last
               let messages = messagesSnap.flatMap { doc in
                   Message(messageId: doc.documentID, data: doc.data())
                }
                
                completion(messages.reversed())
            }
    }
    
    func loadOneMessage(onvoId: String, completion: @escaping (Message) -> Void) {
        guard let lastSnapshot else { return }
        Firestore.firestore()
            .collection(.conversation)
            .document(onvoId)
            .collection(.messages)
            .start(afterDocument: lastSnapshot)
            .order(by: "date", descending: true)
            .limit(to: 1)
            .addSnapshotListener { snap, error in
                guard error == nil else { return }
                
                if let hasPending = snap?.metadata.hasPendingWrites, !hasPending {
                    guard let messageSnap = snap?.documents, let message = messageSnap.first else { return }
                    
                    let lastMessage = Message(messageId: message.documentID, data: message.data())
                    
                    self.lastSnapshot = message
                    completion(lastMessage)
                }
                
                
            }
    }
}
