//
//  ChannelCategoryEntity.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import ObjectMapper

public class ChannelCategoryEntity: BaseEntity {
    public var dataArray: [CategoryEntity]?

    public required init?(map: Map) {
        super.init(map: map)
        dataArray <- map["data_array"]
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        dataArray <- map["data_array"]
    }
}

public class CategoryEntity: Mappable {
    public var categoryIdX: String?
    public var categoryName: String?
    public var insDate: String?


    public required init?(map: Map) {
        categoryIdX <- map["category_idx"]
        categoryName <- map["category_name"]
        insDate <- map["ins_date"]
    }

    public func mapping(map: Map) {
        categoryIdX <- map["category_idx"]
        categoryName <- map["category_name"]
        insDate <- map["ins_date"]
    }
}
