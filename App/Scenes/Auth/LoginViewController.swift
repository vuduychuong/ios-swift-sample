//
//  LoginViewController.swift
//  App
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var tfUserName: CustomTextField!
    @IBOutlet weak var tfPassword: CustomTextField!
    @IBOutlet weak var btnLogin: GradientButton!
    @IBOutlet weak var btnRemember: UIButton!

    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    }

    func bindView() {
    }

    func bindViewModel() {
        assert(nil != viewModel)
        self.viewModel.bindView(view: self)
        btnLogin.rx.tap
            .asDriver()
            .throttle(.milliseconds(500), latest: false)
            .drive(onNext: { _ in
                self.view.endEditing(true)
                self.viewModel.login(userName: self.tfUserName.text, password: self.tfPassword.text)
            })
            .disposed(by: disposeBag)
    }

    func openMainScreen() {
        Application.shared.configureMainInterface(in: self.navigationController!)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
