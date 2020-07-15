//
//  NSLocalizedString.swift
////
//  Created by Chuong Vu Duy on 11/1/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

class Localizable {

    static func getString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

}
