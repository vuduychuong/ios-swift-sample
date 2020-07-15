//
//  Date+Extensions.swift
////
//  Created by Chuong Vu Duy on 11/15/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Foundation
public let DATE_FORMAT_ISO: String = "yyyy-MM-dd'T'HH:mm:ssZ"
public let DATE_FORMAT_YYYY: String = "yyyy"
public let DATE_FORMAT_YYYYMMDD: String = "yyyyMMdd"
public let DATE_FORMAT_YYYY_MM_DD: String = "yyyy/MM/dd"
public let DATE_FORMAT_DOT_YYYY_MM_DD: String = "yyyy.MM.dd"
public let DATE_FORMAT_YYYY_MM_DD_HH_MM: String = "yyyy/MM/dd  HH:mm"
public let DATE_FORMAT_DASH_YYYY_MM_DD_HH_MM: String = "yyyy-MM-dd  HH:mm"
public let DATE_FORMAT_NORMAL: String = "yyyy-MM-dd"
public let DATE_FORMAT_ISO_FULL: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"

extension Date {
    static func changeDateFormat(strDate: String, oldFormat: String, newFormat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = oldFormat

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = newFormat

        if let date = dateFormatterGet.date(from: strDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            return strDate
        }
    }

    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
