//
//  CALayer+Extensions.swift
//  App
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }

        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
