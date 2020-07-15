//
//  ItemChannelNavigator.swift
//  App
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit
import Domain

protocol DefaultItemChannelNavigator {
    func openChannelDetail(_ item: ChannelEntity)
}

class ItemChannelNavigator: DefaultItemChannelNavigator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func openChannelDetail(_ item: ChannelEntity) {
        guard let channelId = item.boardId else { return }
        let navigator = ChannelDetailNavigator(navigationController: self.navigationController)
        let vc = ChannelDetailViewController()
        vc.viewModel = ChannelDetailViewModel(navigator: navigator, channelId: channelId)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
