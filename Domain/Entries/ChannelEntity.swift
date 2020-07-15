//
//  ChannelEntity.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//
//{
//    "board_idx": "17",
//    "board_type": "board",
//    "ins_date": "2020.05.05",
//    "title": "5월 제철식재료 딸기",
//    "img_path": "http://dev-admin.martjangbogo.com/media/commonfile/202005/08/f891bab61fabf768e98b6d1f95ab7d41.png",
//    "reply_cnt": "0",
//    "like_cnt": "0",
//    "my_like_yn": "N",
//    "category": "오늘뭐먹지",
//    "contents_yn": "Y"
//}
import ObjectMapper

public class ChannelEntity: BaseEntity {
    public var boardId: String?
    public var boardType: String?
    public var corpIdx: String?
    public var corpName: String?
    public var insDate: String?
    public var title: String?
    public var boardImg: String?
    public var viewCnt: String?
    public var contents: String?
    public var imgPath: String?
    public var replyCnt: String?
    public var likeCnt: String?
    public var myLikeYn: String?
    public var myScrapYn: String?
    public var category: String?
    public var contentsYn: String?

    
    public required init?(map: Map) {
        super.init(map: map)
        boardId <- map["board_idx"]
        boardType <- map["board_type"]
        corpIdx <- map["corp_idx"]
        corpName <- map["corp_name"]
        insDate <- map["ins_date"]
        title <- map["title"]
        boardImg <- map["board_img"]
        viewCnt <- map["view_cnt"]
        contents <- map["contents"]
        imgPath <- map["img_path"]
        replyCnt <- map["reply_cnt"]
        likeCnt <- map["like_cnt"]
        myLikeYn <- map["my_like_yn"]
        myScrapYn <- map["my_scrap_yn"]
        category <- map["category"]
        contentsYn <- map["contents_yn"]
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        boardId <- map["board_idx"]
        boardType <- map["board_type"]
        corpIdx <- map["corp_idx"]
        corpName <- map["corp_name"]
        insDate <- map["ins_date"]
        title <- map["title"]
        boardImg <- map["board_img"]
        viewCnt <- map["view_cnt"]
        contents <- map["contents"]
        imgPath <- map["img_path"]
        replyCnt <- map["reply_cnt"]
        likeCnt <- map["like_cnt"]
        myLikeYn <- map["my_like_yn"]
        myScrapYn <- map["my_scrap_yn"]
        category <- map["category"]
        contentsYn <- map["contents_yn"]
    }
}
