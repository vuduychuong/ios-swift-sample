//
//  MSplashViewController.swift
////
//  Created by Chuong Vu Duy on 12/6/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import NetworkPlatform
import Domain
import RxSwift

let TESTNET = 2
let MAINET = 3


#if DEBUG_COMMERCIAL
let NETWORK_INDEX = 2
#else
let NETWORK_INDEX = 3
#endif


class MSplashViewController: UIViewController {

    var deviceId: SecKey!

    var delegate: AppDelegate!

    var networkUseCaseProvider: Domain.UseCaseProvider!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = UIApplication.shared.delegate as? AppDelegate
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.start()
    }

    func start() {
        // Set Network index for whole app
        gotoPage()
    }

    func gotoPage() {
        let token = UserDefaultsHelper.getUserToken()
        if token.count == 0 {
            guard let navigationController = self.navigationController else {
                return
            }
            navigationController.setNavigationBarHidden(true, animated: false)
            let navigator = LoginNavigator(navigationController: navigationController)
            let vc = LoginViewController()
            vc.viewModel = LoginViewModel(navigator: navigator)
            self.navigationController?.pushViewController(vc, animated: false)
            return
        }
        Application.shared.configureMainInterface(in: self.navigationController!)
    }
}
