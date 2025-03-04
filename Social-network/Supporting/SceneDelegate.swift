//
//  SceneDelegate.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let viewModel = FeedViewModel()
        let initialVC = viewModel.start() as! UIViewController
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = initialVC
        self.window = window
        window.makeKeyAndVisible()
    }


}

