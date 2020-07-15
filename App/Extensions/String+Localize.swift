//
//  String+Localize.swift
////
//  Created by Chuong Vu Duy on 11/1/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

protocol Localization {
    var localized: String { get }
}
extension String: Localization {
    var localized: String {
        return Localizable.getString(key: self)
    }
}
