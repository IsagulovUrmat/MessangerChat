//
//  SceneDelegate.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit
import Firebase

enum WindowManager {
    case auth, reg, app
}


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(windowManager(notification: )), name: .windowManager, object: nil)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = FirebaseManager.shared.isLoging() ? Builder.getTabView(): Builder.getAuthView()
        window?.makeKeyAndVisible()
        
    }
    
    @objc private func windowManager(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        guard let state = userInfo[String.state] as? WindowManager else { return }
        
        switch state {
        case .auth:
            window?.rootViewController = Builder.getAuthView()
        case .reg:
            window?.rootViewController = Builder.getRegView()
        case .app:
            window?.rootViewController = Builder.getTabView()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

