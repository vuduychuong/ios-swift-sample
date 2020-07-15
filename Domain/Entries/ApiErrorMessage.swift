//
//  ApiErrorMessage.swift
//  Domain
//
//  Created by Chuong Vu Duy on 11/27/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import ObjectMapper

public struct ApiErrorMessage: Mappable, Codable {

    public var status: String?
    public var details: String?

    public init?(map: Map) {
        status <- map["status"]
        details <- map["details"]
    }

    public init(status: String, details: String) {
        self.status = status
        self.details = details
    }

    mutating public func mapping(map: Map) {
      status <- map["status"]
      details <- map["details"]
    }
}
