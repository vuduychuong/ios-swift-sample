//
//  UIViewController+Extensions.swift
////
//  Created by Chuong Vu Duy on 12/17/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Alamofire

extension UIViewController {

    func isNetworkConnected(isShowPopup: Bool = true) -> Bool{
        if !(NetworkReachabilityManager()?.isReachable ?? false) {
            if isShowPopup {
                let alert = CustomAlertView(title: "alert-network-title".localized, content: "alert-network-error".localized)
                alert.show(animated: true)
            }
            return false
        }
        return true
    }
}
