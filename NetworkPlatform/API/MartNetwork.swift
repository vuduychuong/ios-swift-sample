//
//  MartNetwork.swift
//  NetworkPlatform
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Domain
import RxSwift

public final class MartNetwork {
    private let network: Network

    init(network: Network) {
        self.network = network
    }

    public func getChannelCategory(parameters: [String: Any]) -> Observable<ApiResult<ChannelCategoryEntity, ApiErrorMessage>> {
        return network.getItem("/board_v_1_0_0/channel_category_list", parameters: parameters)
    }

    public func getChannelList(parameters: [String: Any]) -> Observable<ApiResult<ChannelListResponse, ApiErrorMessage>> {
        return network.getItem("/board_v_1_0_0/channel_list", parameters: parameters)
    }

    public func getChannelDetail(parameters: [String: Any]) -> Observable<ApiResult<ChannelEntity, ApiErrorMessage>> {
        return network.getItem("/board_v_1_0_0/channel_detail", parameters: parameters)
    }
}
