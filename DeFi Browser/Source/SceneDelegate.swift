//
//  SceneDelegate.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 20/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let appCoordinator = AppCoordinator()

        window = UIWindow(windowScene: windowScene)

        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()

    }

}
