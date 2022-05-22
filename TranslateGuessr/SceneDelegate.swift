//
//  SceneDelegate.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let configurator = EvaluatorSceneConfigurator()
        let controller = configurator.build()
        window.rootViewController = controller

        self.window = window
        window.makeKeyAndVisible()
    }
}

