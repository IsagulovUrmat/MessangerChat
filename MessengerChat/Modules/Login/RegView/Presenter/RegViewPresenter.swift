//
//  RegViewPresenter.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

protocol RegViewPresenterProtocol: AnyObject {
    init(view: RegViewProtocol)
    func sendToRegist(userInfo: UserInfo)
}

class RegViewPresenter: RegViewPresenterProtocol {
   
    private let registManager = RegistaionManager()
    private let validator = FieldValidator()
    weak var view: RegViewProtocol?
    
    required init(view: any RegViewProtocol) {
        self.view = view
    }
    
    func sendToRegist(userInfo: UserInfo) {
        
        if validator.isValid(.email, userInfo.email), validator.isValid(.password, userInfo.password) {
            registManager.createUser(userInfo: userInfo) { result in
                switch result {
                case .success(let success):
                    if success {
                        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.app])
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        } else {
            print("alert")
        }
        
    }
    
    
    
}
