//
//  RegistaionManager.swift
//  MessengerChat
//
//  Created by sunflow on 3/3/25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegistaionManager {
    
    func createUser(userInfo: UserInfo, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password) { [weak self] result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let self = self else { return }
            guard let result else { return }
            
            
            result.user.sendEmailVerification()
            setUserInfo(uid: result.user.uid, userInfo: userInfo) {
                completion(.success(true))
            }
            
        }
    }
    
    private func setUserInfo(uid: String, userInfo: UserInfo, completion: @escaping () -> Void) {
        
        let userData: [String: Any] = [
            "name": userInfo.name ?? "",
            "email": userInfo.email,
            "regDate": Date(),
        ]
        
        Firestore.firestore()
            .collection(.users)
            .document(uid)
            .setData(userData) { _ in
                completion()
            }
    }
}


