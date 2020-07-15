//
//  UserEntity.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import ObjectMapper

public class UserEntity: BaseEntity, Encodable {
    public var memberIdX: String?
    public var memberId: String?
    public var memberName: String?

    public required init?(map: Map) {
        super.init(map: map)
        memberIdX <- map["member_idx"]
        memberId <- map["member_id"]
        memberName <- map["member_name"]
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        memberIdX <- map["member_idx"]
        memberId <- map["member_id"]
        memberName <- map["member_name"]
    }
}
