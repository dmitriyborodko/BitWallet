import UIKit

class Coordinator {

    var rootVC: UIViewController { tabBarController }

    private let tabBarController = UITabBarController()
    private let assetsNavigationController = UINavigationController()
    private let assetsVC = AssetsVC()
    private let walletsNavigationController = UINavigationController()
    private let walletsVC = WalletsVC()

    init() {
        configureUI()
    }

    private func configureUI() {
        assetsNavigationController.tabBarItem = UITabBarItem(title: "Assets", image: #imageLiteral(resourceName: "dolar"), tag: Constants.assetsVCTag)
        walletsNavigationController.tabBarItem = UITabBarItem(title: "Wallets", image: #imageLiteral(resourceName: "card"), tag: Constants.walletsVCTag)

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
