//
//  SceneDelegate.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let sceneFactory = DefaultSceneFactory()
        sceneFactory.configurator = DefaultLoginSceneConfigurator(sceneFactory: sceneFactory)
        let navController = UINavigationController(rootViewController: sceneFactory.makeLoginScene())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
