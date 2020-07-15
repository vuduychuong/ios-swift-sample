//
//  HomeNavigator.swift
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit


protocol HomeNavigator {
    func toHome()
}

class DefaultHomeNavigator: HomeNavigator {

    private let rootNavigationController: UINavigationController
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, rootNavigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootNavigationController = rootNavigationController
    }

    func toHome() {
        let vc = HomeViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
