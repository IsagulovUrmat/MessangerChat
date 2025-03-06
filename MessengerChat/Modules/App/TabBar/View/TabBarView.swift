//
//  TabBar.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setControllers(views: [UIViewController] )
}

class TabBarView: UITabBarController, TabBarViewProtocol {
    
    var presenter: TabBarPresenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setControllers(views: [UIViewController]) {
        setViewControllers(views, animated: false)
    }
    
    
    
}
