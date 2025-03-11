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
        let view = FeedView()
        let repository = FeedRepository()
        viewModel.start(view: view, repository: repository)
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = view
        self.window = window
        window.makeKeyAndVisible()
    }


}

