//
//  ViewControllerProtocol.swift
////
//  Created by Chuong Vu Duy on 11/4/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

protocol ViewControllerProtocol {

    func bindView()

    func bindViewModel()

    func showWarning(title: String, content: String)

    func showLoading()

    func hideLoading()
}

extension ViewControllerProtocol {
    func showWarning(title: String, content: String) {
        let alert = CustomAlertView(title: title, content: content)
        alert.show(animated: true)
    }

    func showLoading() {
        MetaActivityIndicator.sharedCPActivity()?.start()
    }

    func hideLoading() {
        MetaActivityIndicator.sharedCPActivity()?.stop()
    }
}
