//
//  UserListManager.swift
//  MessengerChat
//
//  Created by sunflow on 3/3/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserListManager {
    
    private let ref = Firestore.firestore()
    private var lastDoc: DocumentSnapshot?
    
    func getAllUsers(completion: @escaping ([ChatUser]) -> Void) {
        var query: Query?
        if lastDoc == nil {
            query = ref
                .collection(.users)
                .limit(to: 10)
        } else {
            query = ref
                .collection(.users)
                .limit(to: 10)
                .start(afterDocument: lastDoc!)
        }
        
        
        
        query!
            .getDocuments { [weak self] snap, error in
                guard let self = self else { return }
                guard error == nil else { return }
                guard let docs = snap?.documents else { return }
                
                self.lastDoc = docs.last
                
//                Task {
                    var users: [ChatUser] = []
                    docs.forEach { user in
                        let userData = user.data()
                        if FirebaseManager.shared.getUser()?.uid != user.documentID {
                            let oneUser = ChatUser(uid: user.documentID, userInfo: userData)
                            users.append(oneUser)
                        }
                        
                    }
                completion(users)
//                    let userList = await self.checkUsersInConvo(users: users)
//                }
            }
    }
    
    private func checkUsersInConvo(users: [ChatUser]) async -> [ChatUser] {
        guard let uid = FirebaseManager.shared.getUser()?.uid else { return []}
        
        var filteredUsers: [ChatUser] = []
        
        for user in users {
            let usersSnap = try? await Firestore.firestore()
                .collection(.conversation)
                .whereField("users", isEqualTo: [uid, user.id])
                .getDocuments()
            
            filteredUsers.append(user)
        }
        
        return filteredUsers
    }
}


