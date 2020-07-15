import Foundation
import UIKit
import Domain
import RxSwift
import RxCocoa
import NetworkPlatform
import RealmPlatform

final class Application {
    static let shared = Application()

    private let networkUseCaseProvider: Domain.UseCaseProvider
    private let disposeBag = DisposeBag()

    var pinCode: String!

    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configureMainInterface(in navigationController: UINavigationController) {
        let tabBarController = UITabBarController()
        let rootNavigationController = RootNavigationController(rootViewController: tabBarController)
        UIApplication.shared.delegate?.window??.rootViewController = rootNavigationController

        //MARK: Home
        let homeNavigationController = UINavigationController()
        homeNavigationController.setNavigationBarHidden(true, animated: false)
        homeNavigationController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        let homeNavigator = DefaultHomeNavigator(navigationController: homeNavigationController, rootNavigationController: rootNavigationController)

        //MARK: Mart
        let martNavigationController = UINavigationController()
        martNavigationController.setNavigationBarHidden(true, animated: false)
        martNavigationController.tabBarItem = UITabBarItem(title: "단골마트", image: UIImage(named: "mart_info"), selectedImage: UIImage(named: "mart_info"))
        let martNavigator = MartNavigator(navigationController: martNavigationController, rootNavigationController: rootNavigationController)

        //MARK: Channel
        let channelNavigationController = UINavigationController()
        channelNavigationController.setNavigationBarHidden(true, animated: false)
        channelNavigationController.tabBarItem = UITabBarItem(title: "장보고채널", image: UIImage(named: "channel"), selectedImage: UIImage(named: "channel"))
        let channelNavigator = ChannelNavigator(navigationController: channelNavigationController, rootNavigationController: rootNavigationController)

        //MARK: More
        let moreNavigationController = UINavigationController()
        moreNavigationController.setNavigationBarHidden(true, animated: false)
        moreNavigationController.tabBarItem = UITabBarItem(title: "더보기", image: UIImage(named: "more"), selectedImage: UIImage(named: "more"))
        let moreNavigator = MoreNavigator(navigationController: moreNavigationController, rootNavigationController: rootNavigationController)

        tabBarController.tabBar.tintColor = UIColor.tealish
        tabBarController.tabBar.barTintColor = UIColor.white
        tabBarController.tabBar.isTranslucent = false;
        tabBarController.viewControllers = [
            homeNavigationController,
            martNavigationController,
            channelNavigationController,
            moreNavigationController
        ]

        rootNavigationController.navigationBar.tintColor = UIColor.white
        rootNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        rootNavigationController.navigationBar.shadowImage = UIImage()
        rootNavigationController.navigationBar.isTranslucent = true
        rootNavigationController.view.backgroundColor = UIColor.white

        homeNavigator.toHome()
        martNavigator.toMart()
        channelNavigator.toChannel()
        moreNavigator.toMore()
    }
}
