//
//  TabBarPresenter.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

protocol TabBarPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
}
class TabBarPresenter: TabBarPresenterProtocol {
    
    weak var view: TabBarViewProtocol?
    
    required init(view: any TabBarViewProtocol) {
        self.view = view
        
        setupControllers()
    }
    
    private func setupControllers() {
        
        let userList = Builder.getUserListView()
        userList.title = .localize("tabUsers")
        userList.tabBarItem.image = UIImage(systemName: "person.3")
        
        let messageList = Builder.getMessageListView()
        messageList.title = .localize("tabMessages")
        messageList.tabBarItem.image = UIImage(systemName: "rectangle.3.group.bubble")
        
        view?.setControllers(views: [userList, messageList])
        
    }
}
