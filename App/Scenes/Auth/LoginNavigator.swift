//
//  LoginNavigator.swift
//  App
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation

protocol DefaultLoginNavigator {
    func openMain()
}

class LoginNavigator: DefaultLoginNavigator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func openMain() {
        
    }
}
