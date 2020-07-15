//
//  MoreViewController.swift
////
//  Created by Chuong Vu Duy on 12/15/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MoreViewController: UIViewController {
    var viewModel: MoreViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func bindView() {
    }

    private func bindViewModel() {
        assert(viewModel != nil)
    }
}
