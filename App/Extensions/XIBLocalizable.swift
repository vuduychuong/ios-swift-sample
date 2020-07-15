//
//  XIBLocalizable.swift
////
//  Created by Chuong Vu Duy on 11/1/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

protocol XIBLocalizable {
    var localString: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var localString: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
extension UIButton: XIBLocalizable {
    @IBInspectable var localString: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}

extension UITextView: XIBLocalizable {
    @IBInspectable var localString: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
   }
}
