//
//  AppDelegate.swift
////
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    var backgroundUpdateTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = UIColor.black24
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black24]
        UINavigationBar.appearance().isTranslucent = false
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

        print("applicationWillResignActive")

        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.endBackgroundUpdateTask()
        })
    }

    func endBackgroundUpdateTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
        self.endBackgroundUpdateTask()
    }

    func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController! {

        if rootViewController.isKind(of: UITabBarController.self) {
            let tabbarController =  rootViewController as! UITabBarController
            return self.topViewControllerWithRootViewController(rootViewController: tabbarController.selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            let navigationController = rootViewController as! UINavigationController
            return self.topViewControllerWithRootViewController(rootViewController: navigationController.visibleViewController)
        } else if ((rootViewController.presentedViewController) != nil){
            let controller = rootViewController.presentedViewController
            return self.topViewControllerWithRootViewController(rootViewController: controller)
        } else {
            return rootViewController
        }
    }

//MARK: Class func
    @objc class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

    @objc class func rootNavigationViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UINavigationController {
        if let navigationController = controller as? UINavigationController {
            return navigationController
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return rootNavigationViewController(controller: selected)
            }
        }
        if let presented = controller?.parent {
            return rootNavigationViewController(controller: presented)
        }
        return (controller?.navigationController)!
    }

    @objc class func rootView() -> UIView {
        return UIApplication.shared.delegate?.window??.rootViewController?.view ?? UIView()
    }

}
