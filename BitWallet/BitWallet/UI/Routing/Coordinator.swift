//
//  Coordinator.swift
//  BitWallet
//
//  Created by Dmitrii Borodko on 12/17/20.
//

import UIKit

class Coordinator {

    // MARK: - Interface

    var rootVC: UIViewController { tabBarController }

    // MARK: - Implementation

    private let assetsVC = AssetsVC()
    private let walletsVC = WalletsVC()
    private let tabBarController = UITabBarController()

    init() {
        configureTabBarController()
    }

    private func configureTabBarController() {
        assetsVC.tabBarItem = UITabBarItem(title: "Assets", image: nil, tag: Constants.assetsVCTag)
        walletsVC.tabBarItem = UITabBarItem(title: "Wallets", image: nil, tag: Constants.walletsVCTag)

        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.viewControllers = [assetsVC, walletsVC]
    }
}

private enum Constants {
    static let assetsVCTag: Int = 0
    static let walletsVCTag: Int = 1
}
