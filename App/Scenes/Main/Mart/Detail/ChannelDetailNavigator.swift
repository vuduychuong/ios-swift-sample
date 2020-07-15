//
//  EventDetailCampagnNavigator.swift
////
//  Created by Chuong Vu Duy on 10/27/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

protocol DefaultChannelDetailNavigator {
}


class ChannelDetailNavigator: DefaultChannelDetailNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
