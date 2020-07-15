//
//  LayoutConstraintUtils.swift
////
//  Created by Chuong Vu Duy on 10/26/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

class LayoutConstraintUtils {
    static func addRatioConstraint(view: UIView!, ratio: CGFloat) {
        view.addConstraint(NSLayoutConstraint(item: view,
        attribute: NSLayoutConstraint.Attribute.width,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: view,
        attribute: NSLayoutConstraint.Attribute.height,
        multiplier: 1 / ratio,
        constant: 0))
    }
}
