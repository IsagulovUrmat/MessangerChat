//
//  FirebaseManager.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {
        
    }
    
    func isLoging() -> Bool {
        return Auth.auth().currentUser?.uid == nil ? false : true
    }
    
    func getUser() -> User? {
        guard let user = Auth.auth().currentUser else { return nil }
        return user
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.auth])
        } catch {
            print("Ошибка при выходе: \(error.localizedDescription)")
        }
    }
}
