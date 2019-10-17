//
//  SceneDelegate.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import RandomUserKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let homeViewController = navigationController.viewControllers.first as? ListViewController else {
                fatalError("The initial view controller should be set to a HomeViewController embedded into a UINavigationController!")
        }
        let configuration = ServerConfig(apiBaseUrl: URL(string: "https://randomuser.me/API")!)
        let apiService = Service(serverConfig: configuration)
        let cacheService = CacheService()
        let viewModel =  ListViewModel(
            repository: RandomUsersRepository(
                service: apiService,
                cacheService: cacheService
            )
        )
        homeViewController.configure(with: viewModel)
    }
    
}

