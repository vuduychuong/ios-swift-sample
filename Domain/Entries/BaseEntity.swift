//
//  BaseEntity.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import ObjectMapper

public let CODE_SUCCESS = "1000"

public class BaseEntity: Mappable {
    public var code: String?
    public var codeMsg: String?

    required public init?(map: Map) {
        code <- map["code"]
        codeMsg <- map["code_msg"]
    }

    public func mapping(map: Map) {
      code <- map["code"]
      codeMsg <- map["code_msg"]
    }
}
