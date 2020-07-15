//
//  RootNavigationController.swift
////
//  Created by Chuong Vu Duy on 4/26/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import NetworkPlatform

class RootNavigationController: UINavigationController {

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
    }
}
