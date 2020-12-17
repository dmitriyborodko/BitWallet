//
//  SceneDelegate.swift
//  BitWallet
//
//  Created by Dmitrii Borodko on 12/17/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let coordinator: Coordinator = .init()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = coordinator.rootVC
        window?.makeKeyAndVisible()
    }
}

