//
//  Builder.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

class Builder {
    
    static func getAuthView() -> UIViewController {
        let view = AuthView()
        let presenter = AuthViewPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    static func getRegView() -> UIViewController {
        let view = RegView()
        let presenter = RegViewPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    static func getTabView() -> UIViewController {
        let view = TabBarView()
        let presenter = TabBarPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    static func getUserListView() -> UIViewController {
        let view = UserListView()
        let presenter = UserListViewPresenter(view: view)
        
        view.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    static func getMessageListView() -> UIViewController {
        let view = MessageListView()
        let presenter = MessageListViewPresenter(view: view)
        
        view.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    static func getMessangerView(chatItem: ChatItem) -> UIViewController {
        let view = MessengerView()
        let presenter = MessengerPresenter(view: view, convoID: chatItem.convoId, otherUserId: chatItem.otherUserID, name: chatItem.name)
        
        view.presenter = presenter
        
        return view
    }
    
    
}


