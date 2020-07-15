//
//  MoreNavigator.swift
////
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

protocol DefaultMoreNavigator {
    func toMore()
}

class MoreNavigator: DefaultMoreNavigator {

    //    private let storyBoard: UIStoryboard
    private let rootNavigationController: UINavigationController
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, rootNavigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootNavigationController = rootNavigationController
    }

    func toMore() {
        let vc = MoreViewController()
        vc.viewModel = MoreViewModel(navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
