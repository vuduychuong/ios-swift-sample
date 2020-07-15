//
//  MyPageNavigator.swift
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import Domain

protocol DefaultMartNavigator {
    func toMart()
}

class MartNavigator: DefaultMartNavigator {

    let rootNavigationController: UINavigationController
    let navigationController: UINavigationController

    init(navigationController: UINavigationController, rootNavigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootNavigationController = rootNavigationController
    }

    func toMart() {
        let vc = MartViewController()
        vc.viewModel = MartViewModel(navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
