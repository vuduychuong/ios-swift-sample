//
//  UIFont+Additions.swift
////
//  Created by Chuong Vu Duy on 10/31/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

extension UIFont {

    public enum SpoqaHanSans: String {
        case Regular = "-Regular"
        case Bold = "-Bold"
    }

    static func spoqaHanSans(_ type: SpoqaHanSans = .Regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "SpoqaHanSans\(type.rawValue)", size: size)!
    }
}
