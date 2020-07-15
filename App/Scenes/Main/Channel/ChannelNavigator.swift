//
//  ChannelNavigator.swift
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import Domain

protocol DefaultChannelNavigator {
    func toChannel()
}

class ChannelNavigator: DefaultChannelNavigator {

    private let rootNavigationController: UINavigationController
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, rootNavigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootNavigationController = rootNavigationController
    }

    func toChannel() {
        let vc = ChannelViewController()
        vc.viewModel = ChannelViewModel(navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
