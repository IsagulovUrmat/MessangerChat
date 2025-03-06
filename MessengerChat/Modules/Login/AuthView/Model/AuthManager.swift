//
//  AuthManager.swift
//  MessengerChat
//
//  Created by sunflow on 3/3/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    
    func auth(userInfo: UserInfo, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: userInfo.email, password: userInfo.password) { result, error in
            guard error == nil else { completion(.failure(error!)); return }
            
            guard let result else { return }
            
            if result.user.isEmailVerified {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
            
            Firestore.firestore()
                .collection(.users)
                .document(result.user.uid)
                .getDocument { snap, error in
                    guard error == nil else { return }
                    if let userData = snap?.data() {
                        let name = userData["name"] as? String ?? ""
                        UserDefaults.standard.set(name, forKey: "selfName")
                    }
                }
        }
    }
}
