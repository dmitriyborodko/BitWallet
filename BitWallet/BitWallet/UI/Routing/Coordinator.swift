import UIKit

class Coordinator {

    // MARK: - Interface

    var rootVC: UIViewController { tabBarController }

    init() {
        configureUI()
    }

    // MARK: - Implementation

    private let tabBarController = UITabBarController()
    private let assetsNavigationController = UINavigationController()
    private let assetsVC = AssetsVC()
    private let walletsNavigationController = UINavigationController()
    private let walletsVC = WalletsVC()

    private func configureUI() {
        assetsNavigationController.tabBarItem = UITabBarItem(title: "Assets", image: nil, tag: Constants.assetsVCTag)
        walletsNavigationController.tabBarItem = UITabBarItem(title: "Wallets", image: nil, tag: Constants.walletsVCTag)

        assetsNavigationController.setViewControllers([assetsVC], animated: false)
        walletsNavigationController.setViewControllers([walletsVC], animated: false)

        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.viewControllers = [assetsNavigationController, walletsNavigationController]
    }
}

private enum Constants {

    static let assetsVCTag: Int = 0
    static let walletsVCTag: Int = 1
}
