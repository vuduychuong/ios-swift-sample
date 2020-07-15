//
//  ChannelListResponse.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import ObjectMapper

public class ChannelListResponse: BaseEntity {
    public var listCnt: String?
    public var pageNum: String?
    public var totalPage: Int?
    public var dataArray: [ChannelEntity]?

    public required init?(map: Map) {
        super.init(map: map)
        listCnt <- map["list_cnt"]
        pageNum <- map["page_num"]
        totalPage <- map["total_page"]
        dataArray <- map["data_array"]
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        listCnt <- map["list_cnt"]
        pageNum <- map["page_num"]
        totalPage <- map["total_page"]
        dataArray <- map["data_array"]
    }
}
