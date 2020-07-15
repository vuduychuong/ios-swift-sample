//
//  Device.swift
////
//  Created by Chuong Vu Duy on 10/26/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

class DeviceUtils {
    static func isIphoneXOrNewer() -> Bool {
        return UIScreen.main.nativeBounds.height >= 1792
    }

    static func getSafeAreaTop(controller: UIViewController) -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow;
            return (window?.safeAreaInsets.top)!;
        } else {
            return controller.topLayoutGuide.length
        }
    }

    static func getSafeAreaBottom(controller: UIViewController) -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow;
            return (window?.safeAreaInsets.bottom)!;
        } else {
            return controller.bottomLayoutGuide.length
        }
    }
}
